# frozen_string_literal: true

class CarryOutDownloadJob < ApplicationJob
  # Possibly download object doesn't exist anymore
  rescue_from ActiveJob::DeserializationError do |exception|
    Rails.logger.error exception.message
  end

  queue_as :corsair

  def perform(download)
    return unless download

    CarryOutDownload.perform(download: download)
  end
end
