class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def set_search
    @search = Recipe.ransack(params[:q]) #ransackの検索メソッド
    @search_recipes = @search.result.page(params[:page])
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[last_name first_name is_gender phone_number])
  end




end
