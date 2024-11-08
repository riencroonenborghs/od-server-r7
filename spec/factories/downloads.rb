# frozen_string_literal: true

FactoryBot.define do
  factory :download do
    url { Faker::Internet.url }
    wget
    queued

    trait :queued do
      status { :queued }
    end

    trait :started do
      status { :started }
      started_at { Time.current }
    end

    trait :finished do
      status { :finished }
      finished_at { Time.current }
    end

    trait :cancelled do
      status { :cancelled }
      cancelled_at { Time.current }
    end

    trait :failed do
      status { :failed }
      failed_at { Time.current }
    end

    trait :wget do
      download_type { :wget }
    end

    trait :released_dot_tv do
      download_type { :released_dot_tv }
    end

    trait :youtube_video do
      download_type { :youtube_video }
    end

    trait :youtube_audio do
      download_type { :youtube_audio }
    end

    trait :bittorrent do
      download_type { :bittorrent }
    end
  end
end

# FactoryBot.define do
#   factory :download do
#     url { "MyString" }
#     status { "MyString" }
#   end

#   factory :released_dot_tv_download do
#     type { "ReleasedDotTvDownload" }
#     url { "http://released.tv/files/foo/bar.baz" }
#     http_username { ENV.fetch("RELEASED_DOT_TV_USERNAME") }
#     http_password { ENV.fetch("RELEASED_DOT_TV_PASSWORD") }
#   end

#   factory :youtube_audio_download do
#     type { "YoutubeAudioDownload" }
#     url { "https://www.youtube.com/watch?v=foobarbaz" }
#     youtube_audio { true }
#     youtube_audio_format { "best" }
#   end

#   factory :youtube_video_download do
#     type { "YoutubeAudioDownload" }
#     url { "https://www.youtube.com/watch?v=foobarbaz" }
#   end

#   trait :youtube_subs do
#     youtube_subs { true }
#   end

#   trait :youtube_srt_subs do
#     youtube_srt_subs { true }
#   end

#   factory :wget_download do
#     type { "WgetDownload" }
#     url { "https://foo.bar.com/baz.olaf" }
#   end

#   trait :http_auth do
#     http_username { "username" }
#     http_password { "password" }
#   end

#   trait :filter do
#     filter { "*1080p*" }
#   end

#   factory :bittorrent_download do
#     url { "magnet:somelongstringgoeshere" }
#   end
# end
