# frozen_string_literal: true

class CarryOutDownload
  include BaseService

  validate :download_queued

  attr_reader :download

  def initialize(download:)
    @download = download
  end

  def perform
    return if invalid?

    prep_output_path
    build_command
    return if failure?

    Rails.logger.info(@command)
    download.started!

    if Kernel.system(@command)
      download.finished!
    else
      logged_fail(error_message: $?)
    end
  rescue => e
    logged_fail(error_message: e.message)
  end

  private

  def download_queued
    return if download.queued?

    errors.add(:base, "Download is not queued")
  end

  def prep_output_path
    dir = ENV.fetch("OUTPUT_PATH")
    FileUtils.mkdir_p(dir) unless File.exists?(dir)
  end

  def build_command
    service = BuildCommand.perform(download: download)
    @command = service.command
    return if service.success?

    errors.merge!(service.errors)
  end

  def logged_fail(error_message:)
    message = "Could not download: #{error_message}"
    download.failed!
    download.update(error_message: message)
    errors.add(:base, message)
    Rails.logger.error(message)
  end
end
