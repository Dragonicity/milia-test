Rails.application.routes.draw do
  get 'purchases/show'

  scope "(:locale)" do
    devise_for :users

    get 'pages/home'
    get '/about',             to: 'pages#about'
    get '/retreat',           to: 'pages#retreat'
    get '/services',          to: 'pages#services'
    get '/products',          to: 'pages#products'
    get '/terms_of_service',  to: 'pages#terms_of_service'
    get '/privacy_policy',    to: 'pages#privacy_policy'

    resources :blogs do 
      member do 
        get :toggle_status
      end
      get 'page/:page', action: :index, on: :collection
    end

    resources :contacts, only: [:new, :create]
    resources :topics, only: [:index, :show]
    resources :charges
    resources :purchases, only: [:show]

    mount ActionCable.server => '/cable'
  
    root to: 'pages#home'
  end
end