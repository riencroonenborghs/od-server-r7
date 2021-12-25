class GoogleDriveDownload < Download
  private

  def command
    ENV["GDL_PATH"]
  end

  def command_options
    []
  end

  def command_output
    "--directory=\"#{ENV["OUTPUT_PATH"]}\""
  end
end
