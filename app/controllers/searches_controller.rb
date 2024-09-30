class SearchesController < ApplicationController
  def new
    @searches = Search.all
    @search = Search.new(quoted: true, incognito: true)
  end

  def create
    service = CreateSearch.perform(params: search_params)

    if service.success?
      redirect_to new_search_path, notice: "Search added"
    else
      @search = service.search
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    search = Search.find(params[:id])
    search.destroy
    redirect_to new_search_path, notice: "Search removed"
  end

  private

  def search_params
    params.require(:search).permit(:query, :query_type, :alternative, :quoted)
  end
end
