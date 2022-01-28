module ApplicationHelper
  def clean_summary(summary)
    return unless summary

    sanitized = sanitize(summary, tags: %w[strong em p a])
    sanitized.gsub(/\<a /, "<a target='_blank' ") # rubocop:disable Style/RedundantRegexpEscape
  end
end
