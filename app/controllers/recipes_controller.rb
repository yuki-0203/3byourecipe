class RecipesController < ApplicationController


  def new
    @recipe = Recipe.new
    @materials = @recipe.materials.build
    @steps = @recipe.steps.build
  end

  def create
    @recipe = Recipe.create(recipe_params)
      redirect_to recipes_path
  end

  def index; end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

    def recipe_params
      params.require(:recipe).permit(:name, :introduction, :note , :image,:user_id,:tag_list,
                               steps_attributes: [:id,:explanation,:image,:recipe_id, :_destroy],
                               materials_attributes: [:id,:name,:recipe_id,:quantity,:serving, :_destroy] )
    end
 end
