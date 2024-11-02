# frozen_string_literal: true

module CommandBuilders
  class YoutubeSubtitlesCommandBuilder < ::CommandBuilders::CommandBuilder
    private

    def command_path
      ENV.fetch("YTDLP_DL_PATH")
    end

    def command_options
      [].tap do |options|
        options << "--continue"
        options << "--write-subs --write-auto-subs" if @download.youtube_subs || @download.youtube_srt_subs
        options << "--convert-subs srt" if @download.youtube_srt_subs
      end
    end

    def command_output
      "--output \"#{ENV.fetch("OUTPUT_PATH")}/%(title)s-%(id)s.%(ext)s\""
    end
  end
end
