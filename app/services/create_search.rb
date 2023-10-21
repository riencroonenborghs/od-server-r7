class CreateSearch
  include Base

  attr_reader :params, :search
  
  def initialize(params:)
    @params = params
  end

  def perform
    parse_params
    create_search
  end

  private

  def parse_params
    params[:query_type] = params[:query_type].to_i
    params[:alternative] = params[:alternative] == "1"
    params[:quoted] = params[:quoted] == "1"
  end

  def create_search
    @search = Search.create!(params)
  end
end