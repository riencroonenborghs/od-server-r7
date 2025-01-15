class DownloadsController < ApplicationController
  skip_forgery_protection

  def index
    redirect_to new_download_path
  end

  def queued
    @downloads = Download.queued.most_recent_first.page(params[:page] || 1)
  end

  def started
    @downloads = Download.started.most_recent_first(:started_at).page(params[:page] || 1)
  end

  def finished
    @downloads = Download.finished.most_recent_first(:finished_at).page(params[:page] || 1)
  end

  def failed
    @downloads = Download.failed.most_recent_first(:failed_at).page(params[:page] || 1)
  end

  def cancelled
    @downloads = Download.cancelled.most_recent_first(:cancelled_at).page(params[:page] || 1)
  end

  def new
    @download = Download.new
  end

  def create
    service = CreateDownload.perform(
      params: download_params,
      youtube_audio_params: youtube_audio_params,
      youtube_subtitles_params: youtube_subtitles_params
    )

    if service.success?
      redirect_to queued_downloads_path, notice: "Download added"
    else
      @download = service.download
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    download = Download.find params[:id]
    status = download.status
    download.destroy
    redirect_to send(:"#{status}_downloads_url"), notice: "Download removed"
  end

  def queue
    download = Download.find params[:id]
    download.queued!
    redirect_to downloads_url, notice: "Download queued"
  end

  def remove_all_fininshed
    Download.finished.map(&:destroy)
    redirect_to finished_downloads_path, notice: "All finished downloads removed"
  end

  private

  def download_params
    params.require(:download).permit(:url, :filter_preset, :filter)
  end

  def youtube_audio_params
    params.require(:download).permit(:youtube_audio, :youtube_audio_format)
  end

  def youtube_subtitles_params
    params.require(:download).permit(:youtube_subs, :youtube_srt_subs)
  end
end
