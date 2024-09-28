module DownloadsHelper
  def download_icon(download)
    download.download_type.camelcase.gsub(/[a-z]/, "").upcase
  end
end
