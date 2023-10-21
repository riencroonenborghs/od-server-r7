class RemoveUserReferences < ActiveRecord::Migration[7.0]
  def up
    remove_column :downloads, :user_id
    remove_column :searches, :user_id
  end

  def down
    raise "can't"
  end
end
