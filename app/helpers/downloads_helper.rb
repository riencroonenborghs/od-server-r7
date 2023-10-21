module DownloadsHelper
  def download_icon(download)
    case download
    when WgetDownload
      fa_solid "download", size: 1
    when BittorrentDownload
      fa_solid "cloud-download-alt", size: 1
    when YoutubeAudioDownload
      fa_brands("youtube", size: 1)
      fa_solid("music", size: 1, classes: "ps-2")
    when YoutubeVideoDownload
      fa_brands("youtube", size: 1) +
      fa_solid("film", size: 1, classes: "ps-2")
    when ReleasedDotTvDownload
      fa_solid "tv", size: 1
    else
      download.class
    end
  end
end
