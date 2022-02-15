class ImpressionsController < ApplicationController

  def create
    @impression = current_user.impressions.new(impression_params)
    recipe = Recipe.find(params[:recipe_id])
    @impression.recipe_id = recipe.id
    if @impression.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    @recipe = Recipe.find(params[:recipe_id])
    @impressions = Impression.where(recipe_id: @recipe.id)
  end

  def destroy
    @impression = Impression.find(params[:id])
  if impression.user_id == current_user.id
   impression.destroy
  end
  end


    private
    def impression_params
      params.require(:impression).permit(:recipe_id,:user_id,:impression,:image,:reply_comment)
    end
end
