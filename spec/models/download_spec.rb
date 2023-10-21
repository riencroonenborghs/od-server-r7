require 'rails_helper'

RSpec.describe Download, type: :model do
  shared_examples "builds the command" do
    it "creates the command" do
      expect(download.build_command).to_not be_nil
    end

    it "has the command, options and output" do
      expect(download.build_command).to eq "#{expected_command} \"#{download.url}\""
    end
  end

  describe ".build_command" do
    before do
      allow(ENV).to receive(:fetch).with("WGET_PATH").and_return("wget")
      allow(ENV).to receive(:fetch).with("GDL_PATH").and_return("gdl")
      allow(ENV).to receive(:fetch).with("YTDLP_DL_PATH").and_return("youtube-dl")
      allow(ENV).to receive(:fetch).with("DELUGE_CONSOLE_PATH").and_return("deluge-console")
      allow(ENV).to receive(:fetch).with("OUTPUT_PATH").and_return("output")
      allow(ENV).to receive(:fetch).with("RELEASED_DOT_TV_USERNAME").and_return("username")
      allow(ENV).to receive(:fetch).with("RELEASED_DOT_TV_PASSWORD").and_return("password")
    end

    context "when it's a bittorrent download" do
      let(:download) { create :bittorrent_download }
      let(:datetime) { DateTime.parse("18 December 2021 16:24:56") }
      let(:expected_command) { "deluge-console add " }

      before { travel_to(datetime) }

      it_behaves_like "builds the command"
    end

    context "when it's a released.tv download" do
      let(:download) { create :released_dot_tv_download }
      let(:expected_command) { "wget -c --reject \"index.html*\" -r -np -e robots=off --random-wait --http-user=\"#{ENV.fetch("RELEASED_DOT_TV_USERNAME")}\" --http-password=\"#{ENV.fetch("RELEASED_DOT_TV_PASSWORD")}\" --no-check-certificate --directory-prefix=\"#{ENV.fetch("OUTPUT_PATH")}\"" }

      it_behaves_like "builds the command"
    end

    context "when it's a wget download" do
      let(:download) { create :wget_download }
      let(:expected_command) { "wget -c --reject \"index.html*\" -r -np -e robots=off --random-wait --no-check-certificate --directory-prefix=\"#{ENV.fetch("OUTPUT_PATH")}\"" }

      it_behaves_like "builds the command"

      context "when there's http auth" do
        let(:download) { create :wget_download, :http_auth }
        let(:expected_command) { "wget -c --reject \"index.html*\" -r -np -e robots=off --random-wait --http-user=\"username\" --http-password=\"password\" --no-check-certificate --directory-prefix=\"#{ENV.fetch("OUTPUT_PATH")}\"" }

        it_behaves_like "builds the command"
      end

      context "when there's a filter" do
        let(:download) { create :wget_download, :filter }
        let(:expected_command) { "wget -c --reject \"index.html*\" -r -np -e robots=off --random-wait --accept \"*1080p*\" --no-check-certificate --directory-prefix=\"#{ENV.fetch("OUTPUT_PATH")}\"" }

        it_behaves_like "builds the command"
      end
    end

    context "when it's a youtube audio download" do
      let(:download) { create :youtube_audio_download }
      let(:expected_command) { "youtube-dl --extract-audio --audio-format \"best\" --audio-quality 0 --continue --output \"#{ENV.fetch("OUTPUT_PATH")}/%(title)s-%(id)s.%(ext)s\"" }

      it_behaves_like "builds the command"
    end

    context "when it's a youtube video  download" do
      context "when no subs are downloaded" do
        let(:download) { create :youtube_video_download }
        let(:expected_command) { "youtube-dl --continue --output \"#{ENV.fetch("OUTPUT_PATH")}/%(title)s-%(id)s.%(ext)s\"" }

        it_behaves_like "builds the command"
      end

      context "when subs are downloaded" do
        let(:download) { create :youtube_video_download, :youtube_subs }
        let(:expected_command) { "youtube-dl --write-subs --continue --output \"#{ENV.fetch("OUTPUT_PATH")}/%(title)s-%(id)s.%(ext)s\"" } 

        it_behaves_like "builds the command"
      end

      context "when SRT subs are downloaded" do
        let(:download) { create :youtube_video_download, :youtube_srt_subs }
        let(:expected_command) { "youtube-dl --write-subs --convert-subs srt --continue --output \"#{ENV.fetch("OUTPUT_PATH")}/%(title)s-%(id)s.%(ext)s\"" }

        it_behaves_like "builds the command"
      end
    end
  end
end
