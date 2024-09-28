# frozen_string_literal: true

module CommandBuilders
  class ReleasedDotTvCommandBuilder < WgetCommandBuilder
    def initialize(download:)
      @download = download
      @download.http_username = ENV.fetch("RELEASED_DOT_TV_USERNAME")
      @download.http_password = ENV.fetch("RELEASED_DOT_TV_PASSWORD")
    end
  end
end
