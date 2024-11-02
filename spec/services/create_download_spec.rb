# fozen_string_literal: true

RSpec.describe CreateDownload do
  subject(:create_download) { described_class.perform(params: params, youtube_audio_params: youtube_audio_params, youtube_video_params: youtube_video_params) }

  let(:params) { { url: url } }
  let(:url) { nil }
  let(:youtube_audio_params) { {} }
  let(:youtube_video_params) { {} }

  before do
    allow(CarryOutDownloadJob).to receive(:perform_later)
  end

  context "when there's wget params" do
    let(:params) { { url: url } }
    let(:url) { Faker::Internet.url }

    it "suceeds" do
      expect(create_download).to be_success
    end

    it "creates a wget download" do
      expect { create_download }.to change { Download.count }.by(1)
      expect(Download.last.download_type).to eq "wget"
    end

    it "sets the URL" do
      create_download
      expect(Download.last.url).to eq url
    end

    context "when there's no filter preset" do
      it "sets no filter" do
        create_download
        expect(Download.last.filter).to be_nil
      end
    end

    context "when there's a filter preset" do
      let(:params) { { url: url, filter_preset: "preset" } }
      let(:url) { Faker::Internet.url }

      it "sets the filter" do
        create_download
        expect(Download.last.filter).to eq "*preset*"
      end
    end
  end

  context "when there's released.tv params" do
    let(:url) { "https://released.tv/something/or/other" }

    it "suceeds" do
      expect(create_download).to be_success
    end

    it "creates a released dot tv download" do
      expect { create_download }.to change { Download.count }.by(1)
      expect(Download.last.download_type).to eq "released_dot_tv"
    end

    it "sets the URL" do
      create_download
      expect(Download.last.url).to eq url
    end
  end

  context "when there's youtube video params" do
    let(:youtube_video_params) { { youtube_subs: true, youtube_srt_subs: true } }
    let(:url) { "https://www.youtube.com/watch?v=5DoAm035yO8" }

    it "suceeds" do
      expect(create_download).to be_success
    end

    it "creates a youtube video download" do
      expect { create_download }.to change { Download.count }.by(1)
      expect(Download.last.download_type).to eq "youtube_video"
    end

    it "sets the URL" do
      create_download
      expect(Download.last.url).to eq url
    end

    it "sets subs settings" do
      create_download
      download = Download.last
      expect(download.youtube_subs).to be_truthy
      expect(download.youtube_srt_subs).to be_truthy
    end
  end

  context "when there's a youtube audio" do
    let(:youtube_audio_params) { { youtube_audio: "true", youtube_audio_format: "best" } }
    let(:url) { "https://www.youtube.com/watch?v=5DoAm035yO8" }

    it "suceeds" do
      expect(create_download).to be_success
    end

    it "creates a youtube audio download" do
      expect { create_download }.to change { Download.count }.by(1)
      expect(Download.last.download_type).to eq "youtube_audio"
    end

    it "sets the URL" do
      create_download
      expect(Download.last.url).to eq url
    end

    it "sets subs settings" do
      create_download
      download = Download.last
      expect(download.youtube_audio).to be_truthy
      expect(download.youtube_audio_format).to eq "best"
    end
  end

  context "when there's a bittorrent" do
    let(:url) { "magnet:?xtn=urn:btih:something" }

    it "suceeds" do
      expect(create_download).to be_success
    end

    it "creates a bittorrent download" do
      expect { create_download }.to change { Download.count }.by(1)
      expect(Download.last.download_type).to eq "bittorrent"
    end

    it "sets the URL" do
      create_download
      expect(Download.last.url).to eq url
    end
  end
end
