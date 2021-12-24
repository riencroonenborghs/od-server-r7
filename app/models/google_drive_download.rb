class GoogleDriveDownload < Download
  private

  def command
    "gdl"
  end

  def command_options
    []
  end

  def command_output
    "--directory=\"#{ENV["OUTPUT_PATH"]}\""
  end
end
