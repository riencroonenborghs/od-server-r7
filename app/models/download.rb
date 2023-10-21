class Download < ApplicationRecord
  FILTER_PRESETS = %w[720 1080 Season1 Season2 Season3 Season4 Season5]

  validates :url, presence: true

  enum status: { queued: 0, started: 1, finished: 2, cancelled: 3, failed: 4 }
  
  scope :most_recent_first, -> (field = :created_at) { order(field => :desc) }

  def build_command
    [].tap do |cmd|
      cmd << command
      cmd.concat(command_options)
      cmd << command_output
      cmd << "\"#{url}\""
    end.join(" ")
  end

  def started!
    super
    update!(started_at: Time.zone.now)
  end

  def finished!
    super
    update!(finished_at: Time.zone.now)
  end

  def cancelled!
    super
    update!(cancelled_at: Time.zone.now)
  end

  def failed!
    super
    update!(failed_at: Time.zone.now)
  end

  def http_auth?
    http_username && http_password
  end

  def queue!
    queued!
    update!(started_at: nil, finished_at: nil, cancelled_at: nil, failed_at: nil)
    DownloadJob.perform_later(id)
  end

  private

  def command
    raise "#command implement me"
  end

  def command_options
    raise "#command_options implement me"
  end

  def command_output
    raise "#command_output implement me"
  end
end
