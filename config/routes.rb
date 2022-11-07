Rails.application.routes.draw do
  get 'chatrooms/index'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/users/:id/chat', to: 'users#showto' ,as: "show_users"
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts do
    resources :comments, only: %i[create destroy]
    member do
      put "like" => "microposts#upvote"
      put "dislike" => "microposts#downvote"
    end
  end
  resources :users do
    member do
    get :following, :followers
    end
    end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :relationships, only: [:create, :destroy]
  resources :chatrooms do 
    resources :messages
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
