class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new

  end

  def confirm
    @recipe = recipe.new(recipe.params)
    if @recipe.invlid?
      render 'new'
    end

  def back
    @recipe = recipe.new(recipe.params)
    render 'new'
  end

  def create

  end

  def index; end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

    def recipe_params
      params.require(:recipe).paramit(:user_id, :name, :introduction, :note , :image_id)
    end
 end
end
