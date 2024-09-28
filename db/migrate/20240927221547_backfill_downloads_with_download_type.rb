class BackfillDownloadsWithDownloadType < ActiveRecord::Migration[7.0]
  def change
    Download.all.each do |dl|
      sql = Download.connection.execute "select * from downloads where id = #{dl.id}"
      sql = sql.first

      case sql["type"]        
      when "ReleasedDotTvDownload"
        dl.download_type = :released_dot_tv
      when "WgetDownload"
        dl.download_type = :wget
      when "BittorrentDownload"
        dl.download_type = :bittorrent
      when "YoutubeVideoDownload"
        dl.download_type = :youtube_video
      when "YoutubeAudioDownload"
        dl.download_type = :youtube_audio
      end

      dl.save
    end
  end
end
