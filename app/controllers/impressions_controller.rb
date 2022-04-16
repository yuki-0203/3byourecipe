class ImpressionsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @impression = current_user.impressions.new(impression_params)
    recipe = Recipe.find(params[:recipe_id])
    @impression.recipe_id = recipe.id
    if @impression.recipe.user == current_user
      redirect_to  recipe_path(@impression.recipe)
    else
      if @impression.save
         #通知（modelにメソッド記載）
        @impression.create_notification_impression!(current_user, @impression.recipe,@impression.recipe.user)
        redirect_to recipe_path(recipe), success: "脱レポを投稿しました！"
      else
        redirect_to recipe_path(recipe) , danger: "投稿できませんでした。感想は1文字以上、50文字以内で入力ください"
      end
    end
  end

  def index
    @recipe = Recipe.find(params[:recipe_id])
    @impressions = Impression.includes([:recipe]).includes([:user]).where(recipe: @recipe.id)
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    Impression.find(params[:id]).destroy
    redirect_to recipe_path(recipe), success: "脱レポを削除しました"
  end

  private
  def impression_params
    params.require(:impression).permit(:recipe_id, :user_id, :impression, :image, :reply_comment)
  end
end
