module TvMaze
  class TvShow < ApplicationRecord
    self.table_name = "tv_maze_tv_shows"

    belongs_to :user

    validates :tv_show_id, :name, :genres, :status, :rating, :images, :summary, presence: true

    serialize :genres, Array
    serialize :images, JSON
  end
end
