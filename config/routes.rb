Rails.application.routes.draw do
  root 'welcome#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts do
    resources :likes
  end
  get 'signup', to: "users#new"
  resources :users, except: [:new]

  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  get 'logout', to: "sessions#destroy"

  resources :categories, except: [:destroy]

end
