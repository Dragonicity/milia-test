Rails.application.routes.draw do
  scope "(:locale)" do
    devise_for :users
    root 'pages#home'
    get 'pages/home'
    get '/about',             to: 'pages#about'
    get '/retreat',           to: 'pages#retreat'
    get '/terms_of_service',  to: 'pages#terms_of_service'
    get '/privacy_policy',    to: 'pages#privacy_policy'

    resources :blogs
    resources :contacts, only: [:new, :create]
  end
end