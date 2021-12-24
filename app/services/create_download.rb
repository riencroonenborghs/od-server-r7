class CreateDownload < AppService
  attr_reader :base_download, :download

  def initialize(base_download:)
    @base_download = base_download
  end

  def call
    @download = if bittorrent?
                  BittorrentDownload.create!(attributes)
                elsif google_drive?
                  GoogleDriveDownload.create!(attributes)
                elsif released_dot_tv?
                  ReleasedDotTvDownload.create!(
                    attributes.update(
                      http_username: ENV["RELEASED_DOT_TV_USERNAME"],
                      http_password: ENV["RELEASED_DOT_TV_PASSWORD"]
                    )
                  )
                elsif youtube_audio?
                  YoutubeAudioDownload.create!(attributes)
                elsif youtube_video?
                  YoutubeVideoDownload.create!(attributes)
                else
                  WgetDownload.create!(attributes)
                end
  rescue StandardError => e
    errors.add(:base, e)
  end

  private

  def attributes
    attrs = base_download.attributes
    attrs.delete("type")
    attrs
  end

  def youtube?
    base_download.url.match?(/youtube\.com|youtu\.be/)
  end

  def youtube_audio?
    youtube? && base_download.youtube_audio?
  end

  def youtube_video?
    youtube? && !base_download.youtube_audio?
  end

  def bittorrent?
    base_download.url.match?(/magnet\:/)
  end

  def google_drive?
    base_download.url.match?(/drive\.google/)
  end
  
  def released_dot_tv?
    base_download.url.match?(/released\.tv/)
  end
end
