Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  get '/posts', to: 'posts#index', as: 'posts'
  get '/post/:id', to: 'posts#show', as: 'post'

  get '/categories', to: 'categories#index', as: 'categories'
  get '/category/:name', to: 'categories#show', as: 'category'

  get '/u/posts', to: 'users_categories#index', as: 'users_posts'
  get '/u/categories', to: 'users_categories#categories', as: 'users_categories'
  post '/u/subscribe_user_category', to: 'users_categories#subscribe_category', as: 'subscribe_user_category'
  post '/u/unsubscribe_user_category', to: 'users_categories#unsubscribe_category', as: 'unsubscribe_user_category'

  use_doorkeeper
  namespace :api do
    get '/posts', to: 'posts#index', as: 'posts'
    get '/post/:id', to: 'posts#show', as: 'post'

    get '/categories', to: 'categories#index', as: 'categories'
    get '/category/:name', to: 'categories#show', as: 'category'

    get '/u/posts', to: 'users_categories#index', as: 'users_posts'
    get '/user', to: 'users_categories#me', as: 'users_details'
    get '/u/categories', to: 'users_categories#categories', as: 'users_categories'
    post '/u/add_user_category', to: 'users_categories#subscribe_category', as: 'add_user_category'
    post '/u/remove_user_category', to: 'users_categories#unsubscribe_category', as: 'remove_user_category'

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
