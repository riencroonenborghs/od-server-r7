# frozen_string_literal: true

class SearchComponent < ViewComponent::Base
  def initialize(search:)
    @search = search
  end

  def search_type
    case @search.query_type
    when "movies"
      "M"
    when "tpb"
      "TPB"
    when "leet"
      "LT"
    when "youtube"
      "YT"
    when "music"
      "M"
    when "books"
      "B"
    when "mac_software"
      "MS"
    when "general"
      "G"
    end
  end
end
