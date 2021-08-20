Rails.application.routes.draw do
  #resources :followings
  post 'users/:id/follow', to: 'followings#follow', as: 'follow_user'
  post 'users/:id/unfollow', to: 'followings#unfollow', as: 'unfollow_user'
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles , only: [:show, :index, :new, :create, :edit,:update, :destroy]
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories, except: [:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
