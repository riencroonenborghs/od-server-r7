class YoutubeVideoDownload < Download
  private

  def command
    "youtube-dl"
  end

  def command_options
    [].tap do |options|
      options << "--write-sub" if youtube_subs || youtube_srt_subs
      options << "--convert-subs srt" if youtube_srt_subs
    end
  end

  def command_output
    "--continue --output \"#{ENV["OUTPUT_PATH"]}/%(title)s-%(id)s.%(ext)s\""
  end
end
