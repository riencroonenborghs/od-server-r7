class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :queue_sizes

  def queue_sizes
    current_user ? current_user.downloads.group(:status).count : {}
  end
  helper_method :queue_sizes

  def download_types
    download_type = Struct.new(:path, :icon, :title, :queue_type, keyword_init: true)
    
    [
      download_type.new(path: started_downloads_path, icon: "download", title: "Started Downloads", queue_type: "started"),
      download_type.new(path: finished_downloads_path, icon: "check", title: "Finished Downloads", queue_type: "finished"),
      download_type.new(path: cancelled_downloads_path, icon: "ban", title: "Cancelled Downloads", queue_type: "cancelled"),
      download_type.new(path: failed_downloads_path, icon: "exclamation-triangle", title: "Failed Downloads", queue_type: "failed")
    ]
  end
  helper_method :download_types
end
