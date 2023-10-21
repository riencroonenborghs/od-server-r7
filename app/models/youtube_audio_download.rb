class YoutubeAudioDownload < Download
  AUDIO_FORMATS = %w[best aac flac mp3 m4a opus vorbis wav]
  
  validates :youtube_audio_format, inclusion: { in: AUDIO_FORMATS }

  private

  def command
    ENV.fetch("YTDLP_DL_PATH")
  end

  def command_options
    ["--extract-audio --audio-format \"#{youtube_audio_format}\" --audio-quality 0"]
  end

  def command_output
    "--continue --output \"#{ENV.fetch("OUTPUT_PATH")}/%(title)s-%(id)s.%(ext)s\""
  end
end
