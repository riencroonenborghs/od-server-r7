class QueuedDownloadsController < ApplicationController
  skip_forgery_protection

  def index
    @downloads = Download.queued.most_recent_first.page(params[:page] || 1)
  end

  def create
    download = Download.find params[:id]
    download.queued!
    redirect_to downloads_url, notice: "Download queued"
  end
end
