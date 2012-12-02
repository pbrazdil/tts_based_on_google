# TTSBasedOnGoogle

This Ruby gem provides Text-to-speech functionality in many languages. Result can be stored in MP3 file or send to output. Based on technologies from Google.

## Installation

Add this line to your application's Gemfile:

    gem 'tts_based_on_google'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tts_based_on_google

## Usage

Basic example:

    file = File.new("test.mp3", "w+")
    TextToSpeech.new("Hi guys, hope you will love it!", :en, file).save_to_file

Or you don't have to specify instance of file, it will automatically write into Tempfile, so if you can just send it to output, try something like this:

    speech = TextToSpeech.new("Hi guys, home you will love it!", :en).save_to_file
    send_file(speech.path, :type => 'audio/mp3', :disposition => 'inline')


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
