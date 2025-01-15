class FailedDownloadsController < ApplicationController
  skip_forgery_protection

  def index
    @downloads = Download.failed.most_recent_first(:failed_at).page(params[:page] || 1)
  end
end
