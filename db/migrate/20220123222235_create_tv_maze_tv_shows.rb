class CreateTvMazeTvShows < ActiveRecord::Migration[7.0]
  def change
    create_table :tv_maze_tv_shows do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :tv_show_id, null: false
      t.string :name, null: false
      t.string :genres, null: false # array of string serialized
      t.string :status, null: false
      t.float :rating, null: false
      t.string :images, null: false # hash serialized
      t.text :summary, null: false
      t.timestamps
    end
  end
end
