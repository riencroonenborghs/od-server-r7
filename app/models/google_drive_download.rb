class GoogleDriveDownload < Download
  private

  def command
    ENV.fetch("GDL_PATH")
  end

  def command_options
    []
  end

  def command_output
    "--directory \"#{ENV.fetch("OUTPUT_PATH")}\""
  end
end
