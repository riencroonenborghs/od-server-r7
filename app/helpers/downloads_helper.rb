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
end
