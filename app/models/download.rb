# frozen_string_literal: true

class Download < ApplicationRecord
  self.ignored_columns = [:type]

  FILTER_PRESETS = %w[720 1080 Season1 Season2 Season3 Season4 Season5]
  AUDIO_FORMATS = []

  validates :url, presence: true

  enum :download_type, wget: 0, released_dot_tv: 1, youtube_video: 2, youtube_audio: 3, bittorrent: 4
  enum :status, queued: 0, started: 1, finished: 2, cancelled: 3, failed: 4
  
  scope :most_recent_first, -> (field = :created_at) { order(field => :desc) }

  def queued!
    super
    update(
      started_at: nil,
      finished_at: nil,
      failed_at: nil,
      error_message: nil,
      cancelled_at: nil
    )

    CarryOutDownloadJob.perform_later(self)
  end

  def started!
    super
    update(started_at: Time.zone.now)
  end

  def finished!
    super
    update(finished_at: Time.zone.now)
  end

  def failed!
    super
    update(failed_at: Time.zone.now)
  end

  def cancelled!
    super
    update(cancelled_at: Time.zone.now)
  end

  def http_auth?
    http_username.present? && http_password.present?
  end
end
