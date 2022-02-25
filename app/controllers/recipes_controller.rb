class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def new
    @recipe = Recipe.new
    @recipe.materials.build
    @recipe.steps.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def index
    # お気に入り登録数を多い順に最大5件表示
    @recipe_favorite_ranks = Recipe.includes([:user]).find(Favorite.group(:recipe_id).order('count(recipe_id) desc').limit(5).pluck(:recipe_id))
    # step数別、新着順にレシピ表示
    @recipe_step_2 = Recipe.includes([:user]).where(steps_count: '2').order(created_at: :desc).page(params[:page]).per(20)
    @recipe_step_3 = Recipe.includes([:user]).where(steps_count: '3').order(created_at: :desc).page(params[:page]).per(20)
    @recipe_step_4 = Recipe.includes([:user]).where(steps_count: '4').order(created_at: :desc).page(params[:page]).per(20)
    @recipe_step_5 = Recipe.includes([:user]).where(steps_count: '5').order(created_at: :desc).page(params[:page]).per(20)
    if params[:tag_name] # タグ検索用
      @tag_name = params[:tag_name]
      @tag_recipe = Recipe.tagged_with(params[:tag_name]) # タグに紐付く投稿
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @tags = @recipe.tag_counts_on(:tags)
    @materials = @recipe.materials
    @steps = @recipe.steps
    @impression = @recipe.impression.new
    @impressions = Impression.preload(:user)
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
    params.require(:recipe).permit(:id, :name, :introduction, :note, :image, :user_id, :tag_list, :serving, :steps_count, :tag_name,
                                   steps_attributes: %i[id explanation image recipe_id _destroy],
                                   materials_attributes: %i[id name recipe_id quantity _destroy])
  end
end
