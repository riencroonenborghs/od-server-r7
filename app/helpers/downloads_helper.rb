module DownloadsHelper
  def download_icon(download)
    case download
    when WgetDownload
      content_tag(:i, nil, class: "bi bi-cloud-arrow-down")
    when GoogleDriveDownload
      content_tag(:i, nil, class: "bi bi-google")
    when BittorrentDownload
      content_tag(:i, nil, class: "bi bi-arrow-down-up")
    when YoutubeAudioDownload
      content_tag(:i, nil, class: "bi bi-youtube") +
        content_tag(:i, nil, class: "bi bi-music-note")
    when YoutubeVideoDownload
      content_tag(:i, " ", class: "bi bi-youtube") +
      content_tag(:i, nil, class: "bi bi-film")
    when ReleasedDotTvDownload
      content_tag(:i, nil, class: "bi bi-tv")
    else
      download.class
    end
  end

  def download_tags(download)
    case download
    when WgetDownload
      concat(
        content_tag(:span, nil, class: "fs-11 badge rounded-pill bg-primary text-light") { download.filter }
      ) if download.filter
      concat(
        content_tag(:span, nil, class: "fs-11 badge rounded-pill bg-secondary text-light") { "HTTP auth" }
      ) if download.http_auth?
    when YoutubeAudioDownload
      content_tag(:span, nil, class: "fs-11 badge rounded-pill bg-info text-light") { download.youtube_audio_format }
    when YoutubeVideoDownload
      pp download
      concat(
        content_tag(:span, nil, class: "fs-11 badge rounded-pill bg-success text-light") { "Subs" }
      ) if download.youtube_subs
      concat(
        content_tag(:span, nil, class: "fs-11 badge rounded-pill bg-warning text-light") { "SRT" }
      ) if download.youtube_srt_subs
    end
  end
end
