Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :homes, only: [:about]
  resources :recipes do
    collection do
     post 'confirm'
    end
      resource :favorites, only: [:create, :destroy]
      resources :impressions
  end
  resources :materials, :steps, :tags,only: [:create, :update, :destroy]
  resources :seachs, only: [:index]
end
