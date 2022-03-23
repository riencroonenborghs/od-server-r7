module ApplicationHelper
  def clean_summary(summary)
    return unless summary

    sanitized = sanitize(summary, tags: %w[strong em p a])
    sanitized.gsub(/\<a /, "<a target='_blank' ") # rubocop:disable Style/RedundantRegexpEscape
  end

  def breadcrumb(*crumbs)
    tag.nav(style: "--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;); background-color: unset;") do
      tag.ol(class: "breadcrumb") do
        crumbs.each do |crumb|
          concat tag.li(class: "breadcrumb-item active") { crumb }
        end
      end
    end
  end
end
