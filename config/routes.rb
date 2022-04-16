Rails.application.routes.draw do
  devise_for :users, controllers: {
   omniauth_callbacks: 'users/omniauth_callbacks',
   registrations: 'users/registrations'}
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root to: 'recipes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resipes,favorites,impressionsコントローラ
  resources :recipes  do
     resource :favorites, only: %i[create destroy]
     resources :impressions , only: %i[index create destroy]
  end

  # materials,stepsコントローラ
  resources :materials, :steps, only: %i[create update destroy]

  # seachsコントローラ
  resources :seachs, only: [:index]

  # usersコントローラ
  resources :users, only: %i[create update edit show] do
    collection do
      get 'profile'
    end
  end
  
  resources :notifications, only: :index
  
end
