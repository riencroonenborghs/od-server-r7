class BittorrentDownload < Download
  private

  def unique_kill_script
    @kill_script ||= "$MYPATH/kill_torrent_#{Time.now.strftime("%Y%m%d-%H%M%S")}.sh"
  end

  def command
    command     = "transmission-cli"
    kill_script = File.join(Rails.root, "bin", "kill_transmission_cli.sh")

    [].tap do |cmd|
      cmd << "MYPATH=`pwd`;"
      cmd << "#{kill_script} \"#{unique_kill_script}\";"
      cmd << command
    end.join(" ")
  end

  def command_options
    [].tap do |options|
      options << "-f \"#{unique_kill_script}\""
      options << "-er -ep" # encrypt
      options << "-D" # no download limit
      options << "-u 10" # upload limit 10 kb/s
    end
  end

  def command_output
    " -w \"#{ENV["OUTPUT_PATH"]}\""
  end
end
