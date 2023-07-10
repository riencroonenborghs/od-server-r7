user = User.create!(email: "rien@croonenborghs.net", password: ENV.fetch("PASSWORD"), password_confirmation: ENV.fetch("PASSWORD"))

types=[WgetDownload, GoogleDriveDownload, ReleasedDotTvDownload, YoutubeAudioDownload, YoutubeVideoDownload]
no_types = types.count
audio_formats = ["best", "aac", "flac", "mp3", "m4a", "opus", "vorbis", "wav"]
no_audio_formats = audio_formats.count

10.times do 
  Download.statuses.keys.each do |status|
    type = types[rand(no_types)]
    data = {
      url: 4.times.map { Faker::Internet.url }.join(""),
      status: status,
      type: type
    }
    case status
    when "queued"
      data[:created_at] = DateTime.now - rand(100).hours
    when "started"
      data[:created_at] = DateTime.now - rand(100).hours
      data[:started_at] = data[:created_at] + 1.hour
    when "finished"
      data[:created_at] = DateTime.now - rand(100).hours
      data[:started_at] = data[:created_at] + 1.hour
      data[:finished_at] = data[:started_at] + rand(10).minutes
    when "failed"
      data[:created_at] = DateTime.now - rand(100).hours
      data[:started_at] = data[:created_at] + 1.hour
      data[:finished_at] = data[:started_at] + rand(10).minutes
      data[:failed_at] = data[:started_at] + rand(10).minutes + 10.minutes
      data[:error_message] = Faker::Quote.famous_last_words
    when "cancelled"
      data[:created_at] = DateTime.now - rand(100).hours
      data[:started_at] = data[:created_at] + 1.hour
      data[:cancelled_at] = data[:started_at] + rand(10).minutes
    end

    # http auth
    if type == WgetDownload
      if rand(10) == 0
        data[:http_username] = Faker::Alphanumeric.alphanumeric(number: 15)
        data[:http_password] = Faker::Alphanumeric.alphanumeric(number: 15)
      end
    end

    # file_filter
    if type == WgetDownload
      if rand(10) == 0
        data[:filter] = "*#{Faker::Alphanumeric.alphanumeric(number: 5)}*"
      end
    end

    if type == YoutubeAudioDownload
      data[:youtube_audio] = true
      data[:youtube_audio_format] = audio_formats[rand(no_audio_formats)]
    end

    # download_subs
    if type ==YoutubeVideoDownload
      if rand(20) == 0
        data[:youtube_subs] = true
        data[:youtube_srt_subs] = rand(10) == 0
      end
    end

    user.downloads.create! data
  end
end