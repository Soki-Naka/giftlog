Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/users/:id/show', to: 'users#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/new_post', to: 'posts#new'
  get '/posts/:id', to: 'posts#show'
  get '/posts/:id/edit', to: 'posts#edit'
  post 'post_like/:id' => 'post_likes#create', as: 'create_like'
  delete 'post_like/:id' => 'post_likes#destroy', as: 'destroy_like'
  get 'users/:id/post_likes' => 'users#post_likes', as: 'user_post_likes'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :posts, only: %i[create update edit destroy] do
    resources :post_likes, only: %i[create destroy]
  end
  resources :relationships, only: %i[create destroy]
end
