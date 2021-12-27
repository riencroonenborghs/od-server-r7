class DownloadJob < ApplicationJob
  def perform(download_id)
    @download = Download.find(download_id)
    return unless download

    prep_output_path
    perform_download!
  end

  private

  attr_reader :download

  def prep_output_path
    dir = ENV['OUTPUT_PATH']
    FileUtils.mkdir_p(dir) unless File.exists?(dir)
  end

  def command
    download.build_command
  end

  def perform_download!
    return if download.cancelled?
    
    download.started!
    system download.build_command
    download.finished!
  rescue StandardError => e
    download.failed!
    download.update!(error_message: e.message)
  end
end