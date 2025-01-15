class FinishedDownloadsController < ApplicationController
  skip_forgery_protection

  def index
    @downloads = Download.finished.most_recent_first(:finished_at).page(params[:page] || 1)
  end
end
