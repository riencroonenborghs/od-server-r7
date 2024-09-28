# frozen_string_literal: true

module CommandBuilders
  class CommandBuilder
    include BaseService

    attr_reader :command

    def initialize(download:)
      @download = download
    end

    def perform
      @command = [].tap do |cmd|
        cmd << command_path
        cmd.concat(command_options)
        cmd << command_output
        cmd << "\"#{@download.url}\""
      end.join(" ")
    end

    private

    def command_path
      raise StandardError, "#command_path needs implementation"
    end

    def command_options
      raise StandardError, "#command_options needs implementation"
    end

    def command_output
      raise StandardError, "#command_output needs implementation"
    end
  end
end
