Rails.application.routes.draw do
  root 'welcome#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts, only: [:show, :index, :new, :create]
end
