class RecipesController < ApplicationController


  def new
    @recipe = Recipe.new
    @material = @recipe.materials.build
    @step = @recipe.steps.build

  end


  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def index; end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

    def recipe_params
      params.require(:recipe).permit(:name, :introduction, :note , :image,:user_id,
                               steps_attributes: [:id,:explanation,:image,:recipe_id, :_destroy],
                               materials_attributes: [:id,:name,:recipe_id,:quantity,:serving, :_destroy] )
    end
 end
