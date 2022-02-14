class ImpressionsController < ApplicationController
  def new
    @impression = Impression.new
    @recipe = Recipe.find(params[:id])
  end

  def create
    @impression = Impression.new(impression_params)
    if @impression.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    @recipe = Recipe.find(params[:id])
    @impressions = Impression.where(recipe_id: @recipe.id)
  end

  def show
    @impression = Impression.find(params[:id])
  end

  def edit
    @impression = Impression.find(params[:id])
  end

  def update
     @impression = Impression.find(params[:id])
    if @impression.update
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @impression = Impression.find(params[:id])
  if impression.user_id == current_user.id
   impression.destroy
  end
  end


    private
    def impression_params
      params.recipe(:impression).permit(:recipe_id,:user_id,:impression,:image,:reply_comment)
end
