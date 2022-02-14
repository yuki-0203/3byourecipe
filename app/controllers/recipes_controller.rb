class RecipesController < ApplicationController


  def new
    @recipe = Recipe.new
    @recipe.materials.build
    @recipe.steps.build
  end

  def create
    @recipe = Recipe.create(recipe_params)
    redirect_to recipes_path
  end

  def index; end

  def show
   @recipe = Recipe.find(params[:id])
   @tags = @recipe.tag_counts_on(:tags)
   @materials = @recipe.materials
   @steps = @recipe.steps
  end

  def edit; end

  def update; end

  def destroy; end

  private

    def recipe_params
      params.require(:recipe).permit(:name, :introduction, :note , :image,:user_id,:tag_list,:serving,
                               steps_attributes: [:id,:explanation,:_destroy],
                               materials_attributes: [:id,:name,:recipe_id,:quantity, :_destroy] )
    end
end
