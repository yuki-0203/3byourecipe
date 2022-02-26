class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
    @recipes = Recipe.eager_load(:user).where(user: @user.id )
    # ユーザーのお気に入りにしているレシピ全てを表示
    favorites = Favorite.eager_load(:user).where(user: @user.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.find(favorites)
    # ユーザーの投稿脱レポの全てを表示
    @impressions = Impression.includes([:recipe]).eager_load(:user).where(user: @user.id)
  end

  def profile
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update!(user_params)
      redirect_to user_path(@user), success: "情報を更新しました！"
    else
      render 'profile', danger: "入力内容をご確認ください"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :phone_number, :is_gender, :nickname, :introduction,
                                 :image, :password)
  end

end
