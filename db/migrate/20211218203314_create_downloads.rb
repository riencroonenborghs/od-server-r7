class CreateDownloads < ActiveRecord::Migration[7.0]
  def change
    create_table :downloads do |t|
      # for all downloads
      t.references :user, null: false, foreign_key: true
      t.string :url, null: false
      t.string :type
      t.integer :status, null: false, default: 0
      t.string :http_username
      t.string :http_password
      t.string :filter
      # youtube audio
      t.boolean :youtube_audio, default: false, null: false
      t.string :youtube_audio_format
      # youtube video
      t.boolean :youtube_subs, default: false, null: false
      t.boolean :youtube_srt_subs, default: false, null: false
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :cancelled_at
      t.datetime :failed_at
      t.string :error_message

      t.timestamps
    end
  end
end
