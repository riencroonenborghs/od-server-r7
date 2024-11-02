# frozen_string_literal: true

module CommandBuilders
  class YoutubeVideoCommandBuilder < ::CommandBuilders::CommandBuilder
    private

    def command_path
      ENV.fetch("YTDLP_DL_PATH")
    end

    def command_options
      ["--continue"]
    end

    def command_output
      "--output \"#{ENV.fetch("OUTPUT_PATH")}/%(title)s-%(id)s.%(ext)s\""
    end
  end
end
