# frozen_string_literal: true

module CommandBuilders
  class BittorrentCommandBuilder < ::CommandBuilders::CommandBuilder
    private

    def command_path
      ENV.fetch("DELUGE_CONSOLE_PATH")
    end

    def command_options
      ["add"]
    end

    def command_output; end
  end
end
