class DownloadsController < ApplicationController
  # before_action :set_download, only: %i[ show edit update destroy ]

  def index
    redirect_to queued_downloads_path
  end

  def queued
    @downloads = current_user.downloads.queued.most_recent_first
  end

  def started
    @downloads = current_user.downloads.started.most_recent_first(:started_at)
  end

  def finished
    @downloads = current_user.downloads.finished.most_recent_first(:finished_at)
  end

  def failed
    @downloads = current_user.downloads.failed.most_recent_first(:failed_at)
  end

  def cancelled
    @downloads = current_user.downloads.cancelled.most_recent_first(:cancelled_at)
  end

  def new
    @download = current_user.downloads.build
  end

  # # GET /downloads/1
  # def show
  # end

  # # GET /downloads/new
  # def new
  #   @download = Download.new
  # end

  # # GET /downloads/1/edit
  # def edit
  # end

  # # POST /downloads
  # def create
  #   @download = Download.new(download_params)

  #   if @download.save
  #     redirect_to @download, notice: "Download was successfully created."
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # # PATCH/PUT /downloads/1
  # def update
  #   if @download.update(download_params)
  #     redirect_to @download, notice: "Download was successfully updated."
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /downloads/1
  # def destroy
  #   @download.destroy
  #   redirect_to downloads_url, notice: "Download was successfully destroyed."
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_download
  #     @download = Download.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def download_params
  #     params.require(:download).permit(:user_id, :url, :status)
  #   end
end
