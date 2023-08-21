Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Set the root path
  root 'welcome#home'

  # Comments routes
  resources :comments

  # Posts routes with nested likes
  resources :posts do
    resources :likes
  end

  # User-related routes
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  # Category-related routes
  resources :categories, except: [:destroy]

  # Custom routes for post actions
  get 'search', to: 'posts#search'
  get 'by_topic', to: 'posts#posts_by_topic'          # working
  get 'top_posts', to: 'posts#top_posts'
  get 'recommended_posts', to: 'posts#recommended_posts'
  get 'save_for_later', to: 'posts#save_for_later'
  get 'drafts', to: 'posts#drafts'
  get 'revisions', to: 'posts#revisions'

  # Profiles routes
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

  # Playlists routes
  resources :playlists, only: [:index, :create, :show] do
    member do
      post 'share'
    end
  end
  post 'playlists/add_post', to: 'playlists#add_post'
  
  # Payment routes
  post 'create_payment', to: 'payments#create_payment'
  post 'confirm_payment', to: 'payments#confirm_payment'
end
