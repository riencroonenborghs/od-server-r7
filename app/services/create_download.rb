class CreateDownload
  include Base

  attr_reader :user, :params, :youtube_audio_params, :youtube_video_params, :download

  def initialize(user:, params:, youtube_audio_params:, youtube_video_params:)
    @user = user
    @params = process_filter_preset(params.to_h)
    @youtube_audio_params = youtube_audio_params.to_h
    @youtube_video_params = youtube_video_params.to_h
  end

  def perform
    build_download
    return unless download

    download.save!
    queue_download if download
  rescue StandardError => e
    errors.add(:base, e)
  end

  private

  def url
    params[:url]
  end

  def audio?
    youtube_audio_params[:youtube_audio] == "true"
  end

  def youtube?
    url.match?(/youtube\.com|youtu\.be/)
  end

  def youtube_audio?
    youtube? && audio?
  end

  def youtube_video?
    youtube? && !audio?
  end

  def bittorrent?
    url.match?(/magnet\:/)
  end

  def google_drive?
    url.match?(/drive\.google/)
  end
  
  def released_dot_tv?
    url.match?(/released\.tv/)
  end

  def build_download
    @download = if bittorrent?
                  user.bittorrent_downloads.build(bittorrent_download_params)
                elsif google_drive?
                  user.google_drive_downloads.build(google_drive_download_params)
                elsif released_dot_tv?
                  user.released_dot_tv_downloads.build(
                    released_dot_tv_params.update(
                      http_username: ENV.fetch("RELEASED_DOT_TV_USERNAME"),
                      http_password: ENV.fetch("RELEASED_DOT_TV_PASSWORD")
                    )
                  )
                elsif youtube_audio? 
                  user.youtube_audio_downloads.build(youtube_audio_download_params)
                elsif youtube_video?
                  user.youtube_video_downloads.build(youtube_video_download_params)
                else
                  user.wget_downloads.build(wget_download_params)
                end
  end

  def process_filter_preset(params)
    filter_preset = params.delete(:filter_preset)
    return params unless filter_preset.present?

    params.update(filter: "*#{filter_preset}*")
  end
  
  def bittorrent_download_params
    { url: params[:url] }
  end

  def google_drive_download_params
    { url: params[:url] }
  end

  def released_dot_tv_params
    { url: params[:url] }
  end

  def youtube_video_download_params
    params.update(youtube_video_params)
  end

  def youtube_audio_download_params
    params.update(youtube_audio_params)
  end

  def wget_download_params
    params
  end

  def queue_download
    DownloadJob.perform_later(download.id)
  end
end
