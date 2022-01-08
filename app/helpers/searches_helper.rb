module SearchesHelper
  def query_types
    {}.tap do |ret|
      Search::query_types.map do |type, value|
        type = type.gsub("_", " ").camelcase
        ret[type] = value
      end
    end
  end

  def query_type_icon(search)
    case search.query_type
    when "movies"
      content_tag(:i, nil, class: "btn bi bi-film")
    when "tpb"
      content_tag(:i, nil, class: "btn bi bi-cloud")
    when "rarbg"
      content_tag(:i, nil, class: "btn bi bi-cloud")
    when "youtube"
      content_tag(:i, nil, class: "btn bi bi-youtube")
    when "music"
      content_tag(:i, nil, class: "btn bi bi-music-not-beamed")
    when "books"
      content_tag(:i, nil, class: "btn bi bi-book")
    when "mac_software"
      content_tag(:i, nil, class: "btn bi bi-apple")
    when "general"
      content_tag(:i, nil, class: "btn bi bi-search")
    end
  end
end
