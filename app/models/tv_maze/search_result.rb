module TvMaze
  class SearchResult < Struct.new(
    :score,
    :tv_show,
    keyword_init: true
  ); end
end
