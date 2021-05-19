Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/users/:id/show', to: 'users#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/guest', to: 'guest_sessions#create'
  get '/new_post', to: 'posts#new'
  get '/search', to: 'posts#search'
  get '/posts/:id', to: 'posts#show'
  get '/posts/:id/edit', to: 'posts#edit'
  post 'post_like/:id' => 'post_likes#create', as: 'create_like'
  delete 'post_like/:id' => 'post_likes#destroy', as: 'destroy_like'
  get 'users/:id/post_likes' => 'users#post_likes', as: 'user_post_likes'
  get 'users/:id/comments' => 'users#comments', as: 'user_comments'
  post 'comment_like/:id' => 'comment_likes#create', as: 'create_comment_like'
  delete 'comment_like/:id' => 'comment_likes#destroy', as: 'destroy_comment_like'
  get 'users/:id/favorite_people' => 'users#favorite_people', as: 'user_favorite_people'
  get '/users/:id/favorite_people/:id', to: 'favorite_people#show'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users do
    member do
      get :favorite_people
    end
  end
  resources :favorite_people, only: %i[create destroy edit update new] do
    member do
      get :gifts
    end
    resources :gifts, only: %i[create destroy new edit update]
  end
  resources :gifts, only: %i[create destroy new edit update]
  resources :posts, only: %i[create new update edit destroy] do
    resources :post_likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy] do
      resources :comment_likes, only: %i[create destroy]
    end
  end
  resources :relationships, only: %i[create destroy]
end
