class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.references :user, null: false, foreign_key: true
      t.string :query
      t.integer :query_type, default: 0, null: false
      t.boolean :alternative
      t.boolean :quoted
      t.boolean :incognito

      t.timestamps
    end
  end
end
