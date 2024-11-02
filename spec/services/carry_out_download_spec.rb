# frozen_string_literal: true

RSpec.describe CarryOutDownload do
  subject(:carry_out_download) { described_class.perform(download: download) }

  let(:download) { create(:download) }
  let(:output_path_exists) { true }
  let(:builder_success) { true }
  let(:builder_command) { "command" }
  let(:builder_errors) { nil }
  let(:kernel_success) { true }

  before do
    allow(ENV).to receive(:fetch).with("OUTPUT_PATH").and_return("foo")
    allow(File).to receive(:exists?).with("foo").and_return(output_path_exists)
    allow(FileUtils).to receive(:mkdir_p).with("foo").and_return(true)
    allow(CommandBuilders::WgetCommandBuilder).to receive(:perform).and_return(double(success?: builder_success, command: builder_command, errors: builder_errors))
    allow(Kernel).to receive(:system).with(builder_command).and_return(kernel_success)
  end
  
  shared_examples "it fails and has an error" do
    it "fails" do
      expect(carry_out_download).to be_failure
    end

    it "has an error" do
      expect(carry_out_download.errors.full_messages).to include expected_error
    end
  end

  context "when download is not queued" do
    let(:download) { create(:download, :started) }
    let(:expected_error) { "[CarryOutDownload] Download is not queued" }

    it_behaves_like "it fails and has an error"
  end

  context "when creating the output path" do
    context "when output path does not exist" do
      let(:output_path_exists) { false }

      it "creates the output path" do
        expect(FileUtils).to receive(:mkdir_p).with("foo")
        carry_out_download
      end
    end

    context "when output path exists" do
      it "does not create the output path" do
        expect(FileUtils).not_to receive(:mkdir_p).with("foo")
        carry_out_download
      end
    end
  end

  context "when building the command" do
    it "builds the command" do
      expect(CommandBuilders::WgetCommandBuilder).to receive(:perform)
      carry_out_download
    end

    it "logs the command" do
      expect(Rails.logger).to receive(:info).with(builder_command)
      carry_out_download
    end

    context "when building the command fails" do
      let(:builder_success) { false }
      let(:builder_command) { nil }
      let(:builder_errors) do
        errors = ActiveModel::Errors.new(CommandBuilders::WgetCommandBuilder)
        errors.add(:base, expected_error)
        errors
      end
      let(:expected_error) { "[WgetCommandBuilder] some error" }

      it_behaves_like "it fails and has an error"
    end
  end

  context "when running the command" do
    it "runs the command" do
      expect(Kernel).to receive(:system).with(builder_command)
      carry_out_download
    end

    context "when running the command fails" do
      let(:kernel_success) { false }
      let(:expected_error) { "[CarryOutDownload] Could not download: Kernel.system failed" }
      
      it_behaves_like "it fails and has an error"

      it "marks the download as failed" do
        expect { carry_out_download }.to change { download.reload.status }.to("failed")
      end
  
      it "sets the error on the download" do
        expect { carry_out_download }.to change { download.reload.error_message }.to(expected_error)
      end
  
      it "logs the error" do
        expect(Rails.logger).to receive(:error).with(expected_error)
        carry_out_download
      end
    end

    context "when running the command goes wrong" do
      let(:expected_error) { "[CarryOutDownload] Could not download: some other error" }

      before do
        allow(Kernel).to receive(:system).with(builder_command).and_raise("some other error")
      end

      it_behaves_like "it fails and has an error"

      it "marks the download as failed" do
        expect { carry_out_download }.to change { download.reload.status }.to("failed")
      end
  
      it "sets the error on the download" do
        expect { carry_out_download }.to change { download.reload.error_message }.to(expected_error)
      end
  
      it "logs the error" do
        expect(Rails.logger).to receive(:error).with(expected_error)
        carry_out_download
      end
    end

    it "marks the download as finished" do
      expect { carry_out_download }.to change { download.reload.status }.to("finished")
    end
  end
end
