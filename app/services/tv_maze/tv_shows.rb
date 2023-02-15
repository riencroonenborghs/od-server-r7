module TvMaze
  class TvShows
    include Base

    def initialize(api_client = ApiClient.new)
      @api_client = api_client
    end

    def search(query)
      search_results = api_client.get(
        api_client.build_url("search/shows?q=#{query}")
      )
      return [] unless success?

      search_results.map do |search_result|
        tv_show = search_result["show"]
        TvMaze::SearchResult.new(
          score: search_result["score"],
          tv_show: TvMaze::TvShow.new(
            tv_show_id: tv_show["id"],
            name: tv_show["name"],
            genres: tv_show["genres"],
            status: tv_show["status"],
            rating: tv_show.dig("rating", "average"),
            images: tv_show["image"],
            summary: tv_show["summary"]
          )
        )
      end
    end

    private

    attr_reader :api_client
  end
end
