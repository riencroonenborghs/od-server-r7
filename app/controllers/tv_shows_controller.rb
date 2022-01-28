class TvShowsController < ApplicationController
  def index
  end

  def search
    if request.post?
      @query = params.dig(:search, :query)

      if @query.present?
        tv_shows = TvMaze::TvShows.new
        @search_results = tv_shows.search(@query)
      else
        @search_results = []
      end
    end
  end

  # def queued
  #   @downloads = current_user.downloads.queued.most_recent_first
  # end

  # def started
  #   @downloads = current_user.downloads.started.most_recent_first(:started_at)
  # end

  # def finished
  #   @downloads = current_user.downloads.finished.most_recent_first(:finished_at)
  # end

  # def failed
  #   @downloads = current_user.downloads.failed.most_recent_first(:failed_at)
  # end

  # def cancelled
  #   @downloads = current_user.downloads.cancelled.most_recent_first(:cancelled_at)
  # end

  # def new
  #   @download = current_user.downloads.build
  # end

  # # # GET /downloads/1
  # # def show
  # # end

  # # # GET /downloads/new
  # # def new
  # #   @download = Download.new
  # # end

  # # # GET /downloads/1/edit
  # # def edit
  # # end

  # def create
  #   service = CreateDownload.call(
  #     user: current_user,
  #     params: download_params,
  #     youtube_audio_params: youtube_audio_params,
  #     youtube_video_params: youtube_video_params
  #   )

  #   if service.success?
  #     redirect_to queued_downloads_path, notice: "Download was successfully created."
  #   else
  #     @download = service.download
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # # # PATCH/PUT /downloads/1
  # # def update
  # #   if @download.update(download_params)
  # #     redirect_to @download, notice: "Download was successfully updated."
  # #   else
  # #     render :edit, status: :unprocessable_entity
  # #   end
  # # end

  # # # DELETE /downloads/1
  # def destroy
  #   download = current_user.downloads.find params[:id]
  #   status = download.status
  #   download.destroy
  #   redirect_to send(:"#{status}_downloads_url"), notice: "Download was successfully removed."
  # end

  # def queue
  #   download = current_user.downloads.find params[:id]
  #   download.queue!
  #   redirect_to downloads_url, notice: "Download was successfully queued again."
  # end
  # private
  # #   # Use callbacks to share common setup or constraints between actions.
  # #   def set_download
  # #     @download = Download.find(params[:id])
  # #   end

  # #   # Only allow a list of trusted parameters through.
  # def download_params
  #   params.require(:download).permit(:url, :filter_preset, :filter)
  # end

  # def youtube_audio_params
  #   params.require(:download).permit(:youtube_audio, :youtube_audio_format)
  # end

  # def youtube_video_params
  #   params.require(:download).permit(:youtube_subs, :youtube_srt_subs)
  # end
end
