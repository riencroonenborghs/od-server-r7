class StartedDownloadsController < ApplicationController
  skip_forgery_protection

  def index
    @downloads = Download.started.most_recent_first(:started_at).page(params[:page] || 1)
  end
end
