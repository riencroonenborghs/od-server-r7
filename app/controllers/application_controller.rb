class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :queue_sizes

  def queue_sizes
    @queue_sizes = current_user ? current_user.downloads.group(:status).count : {}
  end
end
