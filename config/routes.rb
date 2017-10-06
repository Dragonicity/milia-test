Rails.application.routes.draw do
  scope "(:locale)" do
    root 'pages#home'
    get 'pages/home'
    get '/about',   to: 'pages#about'
    get '/contact', to: 'pages#contact'
  end
end