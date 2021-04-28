Rails.application.routes.draw do
  root "posts#index"
  get "/posts", to: "posts#index"
  get '/search' => 'posts#search', :as => 'search_page'
  
  devise_for :users
  resources :posts do 
    resources :comments
  end
end
