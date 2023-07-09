Rails.application.routes.draw do
  root "posts#index"
  
  devise_for :users
  
  resources :posts do
    resources :comments, except: :show
  end
  resources :categories, except: :show

  namespace :user do
    resources :comments, :posts
  end
end
