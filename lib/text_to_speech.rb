require "tts_based_on_google/version"
require 'net/http'
require 'tempfile'
require 'uri'

class TextToSpeech
  URL_HOST = "translate.google.com"
  URL_PATH = lambda { |text, lang| "/translate_tts?ie=UTF-8&q=#{URI.escape(text)}&tl=#{lang}" }

  def initialize(text, lang = :en, file = Tempfile.new("tts_mp3"))
    @full_text = escape_text(text)
    @lang = lang.to_s if lang.class == Symbol
    @file = file
  end

  def save_to_file
    convert_to_speech

    @file
  end


  private
  def convert_to_speech
    str = ""
    parts = [] # each part's size has to be lower then 100 chars, in order to get working with google

    splitted = split_text_into_parts

    # join sentences or words into parts that has lower size then 100
    until splitted.empty?
      # if text's size will be bigger then 100, we first need to download speech for this text, then reset it
      # google don't support TTS for texts bigger then 100 chars
      if (str + splitted[0]).size > 100
        parts << str
        str = ""
      else
        str += splitted[0]
        str += " "
        splitted.delete_at(0)
      end
    end

    parts << str

    download_speech(parts)
  end

  def split_text_into_parts
    splitted = []

    # let's split by sentences
    @full_text.split(".").each do |sentence|
      #if sentence is bigger, then split by words
      if sentence.size >= 100
        sentence.split(" ").each { |word| splitted << word }
      else
        splitted << sentence + "."
      end
    end
    splitted
  end

  def download_speech(parts)
    #binding.pry
    Net::HTTP.start(URL_HOST) do |http|
      open(@file.path, "ab") do |file|
        parts.each do |part|
          response = http.get(URL_PATH.call(part, @lang))
          file.write(response.body)
        end
      end
    end
  end

  def escape_text(text)
    text.squeeze!(".")
    text.gsub!("\n", " ")
    text.gsub!("\r", " ")
    text.squeeze!(" ")
    text
  end
end


