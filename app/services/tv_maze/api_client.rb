module TvMaze
  class ApiClient
    include Base

    def initialize(url: "http://api.tvmaze.com/")
      @url = url
    end

    def build_url(path)
      "#{url}#{path}"
    end

    def get(url)
      data = HTTParty.get(url)&.body
      JSON.parse(data)
    rescue StandardError => e
      errors.add(:base, e.message)
    end

    private
    
    attr_reader :url
  end
end
