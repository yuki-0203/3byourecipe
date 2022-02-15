class RecipesController < ApplicationController


  def new
    @recipe = Recipe.new
    @recipe.materials.build
    @recipe.steps.build
  end

  def create
    @recipe = Recipe.new (recipe_params)
    if @recipe.save
        redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def index
  end

  def show
   @recipe = Recipe.find(params[:id])
   @tags = @recipe.tag_counts_on(:tags)
   @materials = @recipe.materials
   @steps = @recipe.steps
  end

   def edit
    @recipe = Recipe.find(params[:id])
   end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(params[:id])
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end


  private

    def recipe_params
      params.require(:recipe).permit(:id,:name, :introduction, :note , :image,:user_id,:tag_list,:serving,
                               steps_attributes: [:id,:explanation,:image,:recipe_id, :_destroy],
                               materials_attributes: [:id,:name,:recipe_id,:quantity, :_destroy] )
    end
end
