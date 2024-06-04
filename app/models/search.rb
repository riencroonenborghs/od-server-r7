class Search < ApplicationRecord
  enum query_type: { movies: 0, tpb: 1, leet: 2, youtube: 3, music: 4, books: 5, mac_software: 6, general: 7 }

  def as_json
    {
      query: query,
      query_type: self.class::query_types[query_type],
      alternative: alternative,
      quoted: quoted
    }
  end
end
