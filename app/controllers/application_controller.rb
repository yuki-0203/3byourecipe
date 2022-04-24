class ApplicationController < ActionController::Base
  add_flash_types :success,:danger
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search,:notifications

      def set_search
        @search = Recipe.ransack(params[:q]) # ransackの検索メソッド
        @search_recipes = @search.result.page(params[:page])
      end
    
      def notifications
        @notifications = Notification.where(visited_id: current_user)

    	#通知一覧に遷移したら、既読済みにする
        #@notifications.where(checked: false).each do |notification|
         # notification.update_attributes(checked: true)
         #end
      end

  protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[last_name first_name is_gender phone_number])
      end
  
end
