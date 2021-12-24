require "rails_helper"

RSpec.describe CreateDownload do
  let(:user) { create :user }
  let(:subject) { described_class.call(base_download: base_download) }

  shared_examples "creates a download" do |klass|
    it "is a success" do
      expect(subject.success?).to be_truthy
    end

    it "creates a #{klass} download" do
      expect { subject }.to change(klass, :count).by(1)
    end
  end

  describe ".call" do
    context "when it's a bittorrent download" do
      let(:base_download) { user.downloads.build(url: "magnet:somelongstringgoeshere") }

      it_behaves_like "creates a download", BittorrentDownload
    end

    context "when it's a google drive download" do
      let(:base_download) { user.downloads.build(url: "https://drive.google.com/file/d/1foobarbaz/view?usp=sharing") }

      it_behaves_like "creates a download", GoogleDriveDownload
    end

    context "when it's a released.tv download" do
      let(:base_download) { user.downloads.build(url: "http://released.tv/files/foo/bar.baz") }

      it_behaves_like "creates a download", ReleasedDotTvDownload

      it "sets http authentication" do
        download = subject.call
        expect(download.http_username).to_not be_nil
        expect(download.http_password).to_not be_nil
      end
    end

    context "when it's a youtube audio download" do
      let(:base_download) { user.downloads.build(url: "https://www.youtube.com/watch?v=foobarbaz", youtube_audio: true, youtube_audio_format: "best") }

      it_behaves_like "creates a download", YoutubeAudioDownload
    end

    context "when it's a youtube audio download" do
      let(:base_download) { user.downloads.build(url: "https://www.youtube.com/watch?v=foobarbaz") }

      it_behaves_like "creates a download", YoutubeVideoDownload
    end

    context "when it's a wget download" do
      let(:base_download) { user.downloads.build(url: "https://foo.bar.com/baz.olaf") }

      it_behaves_like "creates a download", WgetDownload
    end
  end
end
