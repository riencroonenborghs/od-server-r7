# frozen_string_literal: true

module CommandBuilders
  class YoutubeAudioCommandBuilder < ::CommandBuilders::CommandBuilder
    private

    def command_path
      ENV.fetch("YTDLP_DL_PATH")
    end

    def command_options
      [].tap do |options|
        options << "--continue"
        options << "--extract-audio"
        options << "--audio-format \"#{@download.youtube_audio_format}\""
        options << "--audio-quality 0"
      end
    end

    def command_output
      "--output \"#{ENV.fetch("OUTPUT_PATH")}/%(title)s-%(id)s.%(ext)s\""
    end
  end
end
