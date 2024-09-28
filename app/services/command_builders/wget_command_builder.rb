# frozen_string_literal: true

module CommandBuilders
  class WgetCommandBuilder < ::CommandBuilders::CommandBuilder
    private

    def command_path
      ENV.fetch("WGET_PATH")
    end

    def command_options
      [].tap do |options|
        options << "-c --reject \"index.html*\" -r -np -e robots=off --random-wait"
        options << "--http-user=\"#{@download.http_username}\" --http-password=\"#{@download.http_password}\"" if @download.http_auth?
        options << "--accept \"#{@download.filter}\"" if @download.filter.present?
        options << "--no-check-certificate"
      end
    end

    def command_output
      "--directory-prefix=\"#{ENV.fetch("OUTPUT_PATH")}\""
    end
  end
end
