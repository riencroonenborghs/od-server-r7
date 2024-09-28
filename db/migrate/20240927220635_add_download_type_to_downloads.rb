class AddDownloadTypeToDownloads < ActiveRecord::Migration[7.0]
  def change
    add_column :downloads, :download_type, :integer, default: 0
  end
end
