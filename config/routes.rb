Rails.application.routes.draw do


root 'posts#home'
resources :users
resources :posts
resources :sessions, except: :index

end
