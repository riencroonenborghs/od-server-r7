class Search < ApplicationRecord
  belongs_to :user

  enum query_type: { movies: 0, tpb: 1, rarbg: 2, youtube: 3, music: 4, books: 5, mac_software: 6, general: 7 }
end
