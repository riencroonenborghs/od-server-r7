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
      fa_solid "film", size: 1
    when "tpb"
      fa_solid "cloud-download-alt", size: 1
    when "youtube"
      fa_brands("youtube", size: 1)
    when "music"
      fa_solid("music", size: 1)
    when "books"
      fa_solid("book-open", size: 1)
    when "mac_software"
      fa_brands("apple", size: 1)
    when "general"
      fa_solid("search", size: 1)
    end
  end
end
