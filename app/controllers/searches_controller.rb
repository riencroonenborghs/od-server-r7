class SearchesController < ApplicationController
  # before_action :set_search, only: %i[ show edit update destroy ]

  # # GET /searches
  # def index
  #   @searches = Search.all
  # end

  # # GET /searches/1
  # def show
  # end

  # GET /searches/new
  def new
    @search = current_user.searches.new(quoted: true, incognito: true)
  end

  # # GET /searches/1/edit
  # def edit
  # end

  # # POST /searches
  # def create
  #   @search = Search.new(search_params)

  #   if @search.save
  #     redirect_to @search, notice: "Search was successfully created."
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # # PATCH/PUT /searches/1
  # def update
  #   if @search.update(search_params)
  #     redirect_to @search, notice: "Search was successfully updated."
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /searches/1
  # def destroy
  #   @search.destroy
  #   redirect_to searches_url, notice: "Search was successfully destroyed."
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_search
  #     @search = Search.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def search_params
  #     params.require(:search).permit(:user_id, :query, :query_type, :alternative, :quoted, :incognito)
  #   end
end
