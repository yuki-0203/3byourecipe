class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @materials = @recipe.materials.build
    @steps = @recipe.steps.build

  end

  def confirm
    @recipe = recipe.new(recipe.params)
    if @recipe.invlid?
      render 'new'
    end
  end

  def back
    @recipe = recipe.new(recipe.params)
    render 'new'
  end

  def create
   @recipe = Recipe.new(recipe_params)
    if @recipe.save!
      redirect_to recipe_path(@recipe), notice: "レシピを投稿しました！"
    else
      render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
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
