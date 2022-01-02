class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  # :registerable, :recoverable
  devise :database_authenticatable, :rememberable, :validatable, :trackable

  has_many :downloads, dependent: :destroy
  has_many :bittorrent_downloads, dependent: :destroy, class_name: "BittorrentDownload"
  has_many :google_drive_downloads, dependent: :destroy, class_name: "GoogleDriveDownload"
  has_many :released_dot_tv_downloads, dependent: :destroy, class_name: "ReleasedDotTvDownload"
  has_many :youtube_audio_downloads, dependent: :destroy, class_name: "YoutubeAudioDownload"
  has_many :youtube_video_downloads, dependent: :destroy, class_name: "YoutubeVideoDownload"
  has_many :wget_downloads, dependent: :destroy, class_name: "WgetDownload"

  has_many :searches, dependent: :destroy
end
