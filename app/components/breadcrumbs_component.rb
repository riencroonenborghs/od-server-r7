# frozen_string_literal: true

class BreadcrumbsComponent < ViewComponent::Base
  def initialize(crumbs: [])
    @crumbs = crumbs
    @no_crumbs = crumbs.size
  end
end
