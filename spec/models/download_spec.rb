require 'rails_helper'

RSpec.describe Download, type: :model do
  shared_examples "builds the command" do |expected_command|
    it "creates the command" do
      expect(download.build_command).to_not be_nil
    end

    it "has the command, options and output" do
      expect(download.build_command).to eq "#{expected_command} \"#{download.url}\""
    end
  end

  describe ".build_command" do
    context "when it's a bittorrent download" do
      let(:download) { create :bittorrent_download }
      let(:datetime) { DateTime.parse("18 December 2021 16:24:56") }

      before { travel_to(datetime) }

      it_behaves_like "builds the command", "MYPATH=`pwd`; #{File.join(Rails.root, "bin", "kill_transmission_cli.sh")} \"$MYPATH/kill_torrent_20211219-052456.sh\"; transmission-cli -f \"$MYPATH/kill_torrent_20211219-052456.sh\" -er -ep -D -u 10  -w \"#{ENV["OUTPUT_PATH"]}\""
    end

    context "when it's a google drive download" do
      let(:download) { create :google_drive_download }

      it_behaves_like "builds the command", "gdl --directory=\"#{ENV["OUTPUT_PATH"]}\""
    end

    context "when it's a released.tv download" do
      let(:download) { create :released_dot_tv_download }

      it_behaves_like "builds the command", "wget -c --reject \"index.html*\" -r -np -e robots=off --random-wait --http-user=\"#{ENV["RELEASED_DOT_TV_USERNAME"]}\" --http-password=\"#{ENV["RELEASED_DOT_TV_PASSWORD"]}\" --no-check-certificate --directory-prefix=\"#{ENV["OUTPUT_PATH"]}\""
    end

    context "when it's a wget download" do
      let(:download) { create :wget_download }

      it_behaves_like "builds the command", "wget -c --reject \"index.html*\" -r -np -e robots=off --random-wait --no-check-certificate --directory-prefix=\"#{ENV["OUTPUT_PATH"]}\""

      context "when there's http auth" do
        let(:download) { create :wget_download, :http_auth }

        it_behaves_like "builds the command", "wget -c --reject \"index.html*\" -r -np -e robots=off --random-wait --http-user=\"username\" --http-password=\"password\" --no-check-certificate --directory-prefix=\"#{ENV["OUTPUT_PATH"]}\""
      end

      context "when there's a filter" do
        let(:download) { create :wget_download, :filter }

        it_behaves_like "builds the command", "wget -c --reject \"index.html*\" -r -np -e robots=off --random-wait --accept \"*1080p*\" --no-check-certificate --directory-prefix=\"#{ENV["OUTPUT_PATH"]}\""
      end
    end

    context "when it's a youtube audio download" do
      let(:download) { create :youtube_audio_download }

      it_behaves_like "builds the command", "youtube-dl --extract-audio --audio-format \"best\" --audio-quality 0 --continue --output \"#{ENV["OUTPUT_PATH"]}/%(title)s-%(id)s.%(ext)s\""
    end

    context "when it's a youtube video  download" do
      context "when no subs are downloaded" do
        let(:download) { create :youtube_video_download }

        it_behaves_like "builds the command", "youtube-dl --continue --output \"#{ENV["OUTPUT_PATH"]}/%(title)s-%(id)s.%(ext)s\""
      end

      context "when subs are downloaded" do
        let(:download) { create :youtube_video_download, :youtube_subs }

        it_behaves_like "builds the command", "youtube-dl --write-sub --continue --output \"#{ENV["OUTPUT_PATH"]}/%(title)s-%(id)s.%(ext)s\""
      end

      context "when SRT subs are downloaded" do
        let(:download) { create :youtube_video_download, :youtube_srt_subs }

        it_behaves_like "builds the command", "youtube-dl --write-sub --convert-subs srt --continue --output \"#{ENV["OUTPUT_PATH"]}/%(title)s-%(id)s.%(ext)s\""
      end
    end
  end
end
