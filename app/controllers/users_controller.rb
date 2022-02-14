class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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
      redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else
      render 'profile'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :phone_number, :is_gender, :nickname, :introduction, :image, :password)
  end
end
