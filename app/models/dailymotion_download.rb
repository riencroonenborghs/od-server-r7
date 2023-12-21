class DailymotionDownload < Download
  private

  def command
    ENV.fetch("YTDLP_DL_PATH")
  end

  def command_options
    []
  end

  def command_output
    "--continue --output \"#{ENV.fetch("OUTPUT_PATH")}/%(title)s-%(id)s.%(ext)s\""
  end
end
