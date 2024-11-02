# frozen_string_literal: true

RSpec.describe BuildCommand do
  subject(:build_command) { described_class.perform(download: download) }

  let(:command_builder) { double(success?: success, command: command, errors: errors) }
  let(:success) { true }
  let(:command) { "command" }
  let(:errors) { nil }

  shared_examples "it fails and has an error" do
    it "fails" do
      expect(build_command).to be_failure
    end

    it "has an error" do
      expect(build_command.errors.full_messages).to include expected_error
    end
  end

  {
    wget: CommandBuilders::WgetCommandBuilder,
    released_dot_tv: CommandBuilders::ReleasedDotTvCommandBuilder,
    youtube_audio: CommandBuilders::YoutubeAudioCommandBuilder,
    youtube_video: CommandBuilders::YoutubeVideoCommandBuilder,
    bittorrent: CommandBuilders::BittorrentCommandBuilder
  }.each do |download_type, builder|
    context "when the download is #{download_type}" do
      let(:download) { create(:download, download_type: download_type) }

      before do
        allow(builder).to receive(:perform).and_return(command_builder)
      end

      it "succeeds" do
        expect(build_command).to be_success
      end

      it "calls #{builder}" do
        expect(builder).to receive(:perform)
        build_command
      end

      it "sets the command" do
        expect(build_command.command).to eq command
      end

      context "when #{builder} fails" do
        let(:success) { false }
        let(:errors) do
          errors = ActiveModel::Errors.new(builder)
          errors.add(:base, expected_error)
          errors
        end
        let(:expected_error) { "[BuildCommand] some error" }
        
        it_behaves_like "it fails and has an error"
      end

      context "when something goes wrong" do
        let(:expected_error) { "[BuildCommand] Could not build command: some other error" }

        before do
          allow(builder).to receive(:perform).and_raise("some other error")
        end

        it_behaves_like "it fails and has an error"
      end
    end
  end
end
