# frozen_string_literal: true

class DownloadComponent < ViewComponent::Base
  include StatusViews

  delegate :fa_solid, to: :helpers

  def initialize(download:, status_views:, actions:)
    @download = download
    @status_views = status_views
    @actions = actions
  end

  def download_type
    @download.download_type.camelcase.gsub(/[a-z]/, "").upcase
  end
  
  def remove?
    @actions.include?(:remove)
  end

  def queue?
    @actions.include?(:queue)
  end
end
