Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :comments
  root 'welcome#home'
  
  resources :posts do
    resources :likes
  end
  get 'signup', to: "users#new"
  resources :users, except: [:new]

  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  get 'logout', to: "sessions#destroy"

  resources :categories, except: [:destroy]

  get 'search', to: "posts#search"

  get 'by_topic', to: "posts#posts_by_topic"

  get 'top_posts', to: "posts#top_posts"

  get 'recommended_posts', to: "posts#recommended_posts"

  get 'save_for_later', to: "posts#save_for_later"

  get 'drafts', to: "posts#drafts"

  get 'revisions', to: "posts#revisions"

    # route for follow and unfollow
    resources :profiles, only: [:show] do
      member do
        post 'follow'
        delete 'unfollow'
      end
      collection do
        get :my_profile
        post :create_profile
      end
    end 

    resources :playlists, only: [:index, :create, :show] do
      member do
        post 'share'
      end
    end
    post 'playlists/add_post', to: 'playlists#add_post'
  
  
    post 'create_payment', to: 'payments#create_payment'
    post 'confirm_payment', to: 'payments#confirm_payment'

end
