class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_favorite = Favorite.new(user_id: current_user.id, recipe_id: params[:recipe_id])
    if @recipe.user != current_user
      @recipe_favorite.save
    else
      redirect_to  recipe_path(@recipe)
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_favorite = Favorite.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])
    if @recipe_favorite.user == current_user
      @recipe_favorite.destroy
    else
      redirect_to  recipe_path(@recipe)
    end
  end
end
