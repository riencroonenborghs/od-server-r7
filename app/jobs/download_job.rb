class DownloadJob < ApplicationJob
  def perform(download_id)
    @download = Download.find(download_id)
    return unless download

    download.started!
    pp "------ #{download.url} started"
    pp download.build_command
    sleep 60
    download.finished!
    pp "------ #{download.url} done"
  end

  private

  attr_reader :download

  def command
    download.build_command
  end
end