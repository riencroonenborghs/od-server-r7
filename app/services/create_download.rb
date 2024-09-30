class CreateDownload
  include BaseService

  attr_reader :download

  def initialize(params:, youtube_audio_params:, youtube_video_params:)
    @params = params.to_h
    @youtube_audio_params = youtube_audio_params.to_h
    @youtube_video_params = youtube_video_params.to_h
  end

  def perform
    handle_filter_preset
    build_base_download
    update_base_download

    if download.save!
      download.queued!
      return
    end

    errors.add(:base, "Could not save download: #{download.errors.full_messages.to_sentence}")
  rescue StandardError => e
    errors.add(:base, "Unexpected: :#{e.message}")
  end

  private

  def handle_filter_preset
    @filter_preset = @params.delete(:filter_preset)
    return unless @filter_preset.present?

    @filter_preset = "*#{filter_preset}*"
  end

  def build_base_download
    @download = Download.new(url: @params[:url], filter: @filter_preset || @params[:filter])
  end

  def update_base_download
    case @download.url
    when /released\.tv/
      @download.download_type = "released_dot_tv"
    when /magnet\:/
      @download.download_type = "bittorrent"
    when /youtube\.com|youtu\.be/
      if @youtube_audio_params[:youtube_audio] == "true"
        @download.download_type = "youtube_audio"
        @download.assign_attributes(@youtube_audio_params)
      else
        @download.download_type = "youtube_video"
        @download.assign_attributes(@youtube_video_params)
      end
    else
      @download.download_type = "wget"
    end
  end
end
