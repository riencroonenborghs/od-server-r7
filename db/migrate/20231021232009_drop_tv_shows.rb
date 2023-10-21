class DropTvShows < ActiveRecord::Migration[7.0]
  def change
    drop_table :tv_maze_tv_shows
  end
end
