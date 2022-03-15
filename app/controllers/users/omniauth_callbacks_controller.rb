# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]
  def twitter
    authorization :twitter
  end

  def google_oauth2
    authorization :google_oauth2
  end

 private

 def authorization(provider)
  provider = provider.to_s

    if user_signed_in?
      
      @user = current_user
      User.attach_social(request.env['omniauth.auth'], @user.id)#後でattach_social作る。SNSからの情報とログイン中のUserのidを渡す。
    else
      @user = User.find_omniauth(request.env['omniauth.auth'])#後でfind_omniauth作る。SNSからの情報を渡す。
    end

    if @user.persisted?#登録済みor登録できたら
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
 end
  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
