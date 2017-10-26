Rails.application.routes.draw do  
  scope "(:locale)" do
    devise_for :users

    get 'pages/home'
    get '/about',             to: 'pages#about'
    get '/privacy_policy',    to: 'pages#privacy_policy'   
    #get '/products',          to: 'pages#products'
    get 'purchases/show',     to: 'purchases#show'
    #get '/retreat',           to: 'pages#retreat'
    get '/services',          to: 'pages#services'
    get '/store_index',       to: 'store#index'
    get 'tags/:tag',          to: 'blogs#index', as: :tag
    get '/terms_of_service',  to: 'pages#terms_of_service'

    resources :blogs do 
      member do 
        get :toggle_status
      end
      get 'page/:page', action: :index, on: :collection
    end
    resources :carts
    resources :charges
    resources :contacts, only: [:new, :create]
    resources :leads
    resources :line_items
    resources :orders
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