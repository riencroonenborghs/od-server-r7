class CancelledDownloadsController < ApplicationController
  skip_forgery_protection

  def index
    @downloads = Download.cancelled.most_recent_first(:cancelled_at).page(params[:page] || 1)
  end
end
