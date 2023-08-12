Rails.application.routes.draw do
  root 'welcome#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  get 'signup', to: "users#new"
  resources :users, except: [:new]

  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  get 'logout', to: "sessions#destroy"

end
