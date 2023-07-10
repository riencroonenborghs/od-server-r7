FactoryBot.define do
  factory :download do
    user { nil }
    url { "MyString" }
    status { "MyString" }
  end

  factory :google_drive_download do
    user
    type { "GoogleDriveDownload" }
    url { "https://drive.google.com/file/d/1foobarbaz/view?usp=sharing" }
  end

  factory :released_dot_tv_download do
    user
    type { "ReleasedDotTvDownload" }
    url { "http://released.tv/files/foo/bar.baz" }
    http_username { ENV.fetch("RELEASED_DOT_TV_USERNAME") }
    http_password { ENV.fetch("RELEASED_DOT_TV_PASSWORD") }
  end

  factory :youtube_audio_download do
    user
    type { "YoutubeAudioDownload" }
    url { "https://www.youtube.com/watch?v=foobarbaz" }
    youtube_audio { true }
    youtube_audio_format { "best" }
  end

  factory :youtube_video_download do
    user
    type { "YoutubeAudioDownload" }
    url { "https://www.youtube.com/watch?v=foobarbaz" }
  end

  trait :youtube_subs do
    youtube_subs { true }
  end

  trait :youtube_srt_subs do
    youtube_srt_subs { true }
  end

  factory :wget_download do
    user
    type { "WgetDownload" }
    url { "https://foo.bar.com/baz.olaf" }
  end

  trait :http_auth do
    http_username { "username" }
    http_password { "password" }
  end

  trait :filter do
    filter { "*1080p*" }
  end

  factory :bittorrent_download do
    user
    url { "magnet:somelongstringgoeshere" }
  end
end
