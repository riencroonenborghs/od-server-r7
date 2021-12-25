class WgetDownload < Download
  private

  def command
    ENV["WGET_PATH"]
  end

  def command_options
    [].tap do |options|
      options << "-c --reject \"index.html*\" -r -np -e robots=off --random-wait"
      options << "--http-user=\"#{http_username}\" --http-password=\"#{http_password}\"" if http_auth?
      options << "--accept \"#{filter}\"" if filter.present?
      options << "--no-check-certificate"
    end
  end

  def command_output
    "--directory-prefix=\"#{ENV["OUTPUT_PATH"]}\""
  end
end
