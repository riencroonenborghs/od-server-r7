# frozen_string_literal: true

module BaseService
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  module ClassMethods
    def perform(...)
      new(...).tap(&:perform)
    end
  end

  def success?
    errors.none?
  end

  def failure?
    !success?
  end

  private

  def add_error(message)
    formatted_message = "[#{self.class.to_s.split("::").last}] #{message}"

    errors.add(:base, formatted_message)
    Rails.logger.error(formatted_message)
  end
end
