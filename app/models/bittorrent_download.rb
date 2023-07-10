class BittorrentDownload < Download
  private

  def command
    ENV.fetch("DELUGE_CONSOLE_PATH")
  end

  def command_options
    ["add"]
  end

  def command_output; end
end
