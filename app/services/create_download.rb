class CreateDownload < AppService
  attr_reader :params, :user, :download

  def initialize(user:, params:)
    @user = user
    @params = params.to_h
  end

  def call
    build_download
    download.save!
  rescue StandardError => e
    pp e
    errors.add(:base, e)
  end

  private

  def url
    params[:url]
  end

  def audio?
    pp "-- params[:youtube_audio]: #{params[:youtube_audio]} => #{!!!params[:youtube_audio]}"
    !!!params[:youtube_audio]
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
                  user.google_drive_downlaods.build(google_drive_download_params)
                elsif released_dot_tv?
                  user.released_dot_tv_downloads.build(
                    released_dot_tv_params.update(
                      http_username: ENV["RELEASED_DOT_TV_USERNAME"],
                      http_password: ENV["RELEASED_DOT_TV_PASSWORD"]
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

  def handle_filter_preset(params)
    filter_preset = params.delete(:filter_preset)
    return params unless filter_preset.present?

    params.update(filter: "*#{filter_preset}*")
  end
  
  def bittorrent_download_params
    handle_filter_preset({ url: params[:url] })
  end

  def google_drive_download_params
    bittorrent_download_params
  end

  def released_dot_tv_params
    handle_filter_preset(wget_download_params)
  end

  def youtube_video_download_params
    handle_filter_preset(
      params.clone.tap do |p|
        p.delete(:youtube_audio)
        p.delete(:youtube_audio_format)
      end
    )
  end

  def youtube_audio_download_params
    handle_filter_preset(
      params.clone.tap do |p|
        p.delete(:youtube_subs)
        p.delete(:youtube_srt_subs)
      end
    )
  end

  def wget_download_params
    handle_filter_preset(
      params.clone.tap do |p|
        p.delete(:youtube_audio)
        p.delete(:youtube_audio_format)
        p.delete(:youtube_subs)
        p.delete(:youtube_srt_subs)
      end
    )
  end 
end
