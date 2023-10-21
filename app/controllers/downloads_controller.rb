class DownloadsController < ApplicationController
  def index
    redirect_to new_download_path
  end

  def queued
    @downloads = Download.queued.most_recent_first
  end

  def started
    @downloads = Download.started.most_recent_first(:started_at)
  end

  def finished
    @downloads = Download.finished.most_recent_first(:finished_at)
  end

  def failed
    @downloads = Download.failed.most_recent_first(:failed_at)
  end

  def cancelled
    @downloads = Download.cancelled.most_recent_first(:cancelled_at)
  end

  def new
    @download = Download.new
  end

  def create
    service = CreateDownload.perform(
      params: download_params,
      youtube_audio_params: youtube_audio_params,
      youtube_video_params: youtube_video_params
    )

    if service.success?
      redirect_to queued_downloads_path, notice: "Download was successfully created."
    else
      @download = service.download
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    download = Download.find params[:id]
    status = download.status
    download.destroy
    redirect_to send(:"#{status}_downloads_url"), notice: "Download was successfully removed."
  end

  def queue
    download = Download.find params[:id]
    download.queue!
    redirect_to downloads_url, notice: "Download was successfully queued again."
  end

  private

  def download_params
    params.require(:download).permit(:url, :filter_preset, :filter)
  end

  def youtube_audio_params
    params.require(:download).permit(:youtube_audio, :youtube_audio_format)
  end

  def youtube_video_params
    params.require(:download).permit(:youtube_subs, :youtube_srt_subs)
  end
end
