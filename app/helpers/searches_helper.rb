module SearchesHelper
  def query_types
    {}.tap do |ret|
      Search::query_types.map do |type, value|
        type = type.gsub("_", " ").camelcase
        ret[type] = value
      end
    end
  end
end
