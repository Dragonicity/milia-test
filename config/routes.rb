Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  get 'store/index'

  get 'purchases/show'

  scope "(:locale)" do
    devise_for :users

    get 'pages/home'
    get '/about',             to: 'pages#about'
    #get '/retreat',           to: 'pages#retreat'
    get '/services',          to: 'pages#services'
    #get '/products',          to: 'pages#products'
    get '/store_index',       to: 'store#index'
    get '/terms_of_service',  to: 'pages#terms_of_service'
    get '/privacy_policy',    to: 'pages#privacy_policy'
    get 'tags/:tag',          to: 'blogs#index', as: :tag

    resources :blogs do 
      member do 
        get :toggle_status
      end
      get 'page/:page', action: :index, on: :collection
    end

    resources :charges
    resources :contacts, only: [:new, :create]
    resources :products do
      get :who_bought, on: :member
    end
    resources :purchases, only: [:show]

    resources :retreats do
      get '/import', action: :import, on: :collection
    end

    resources :subscriptions
    resources :topics, only: [:index, :show]

    mount ActionCable.server => '/cable'
  
    root to: 'pages#home'
  end
end