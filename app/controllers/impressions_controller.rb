class ImpressionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @impression = current_user.impressions.new(impression_params)
    recipe = Recipe.find(params[:recipe_id])
    @impression.recipe_id = recipe.id
    if @impression.save
      redirect_to recipe_path(recipe)
    else
      render 'new'
    end
  end

  def index
    @recipe = Recipe.find(params[:recipe_id])
    @impressions = Impression.includes([:user])
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
      Impression.find(params[:id]).destroy
      redirect_to recipe_path(recipe)
  end


    private
    def impression_params
      params.require(:impression).permit(:recipe_id,:user_id,:impression,:image,:reply_comment)
    end
end
