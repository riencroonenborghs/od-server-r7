# frozen_string_literal: true

class BuildCommand
  include BaseService

  attr_reader :command

  def initialize(download:)
    @download = download
  end

  def perform
    builder = builder_klass.perform(download: @download)
    if builder.success?
      @command = builder.command
      return
    end

    errors.merge!(builder.errors)
  rescue StandardError => e
    add_error("Could not build command: #{e.message}")
  end

  private

  def builder_klass
    ["command_builders", "#{@download.download_type}_command_builder"].map(&:camelcase).join("::").constantize
  end
end
