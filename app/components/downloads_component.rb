# frozen_string_literal: true

class DownloadsComponent < ViewComponent::Base
  include StatusViews

  def initialize(downloads:, status_views:, actions: [])
    @downloads = downloads
    @status_views = status_views
    @actions = actions
  end

  def finished_dowloads?
    Download.finished.count.nonzero?
  end
end
