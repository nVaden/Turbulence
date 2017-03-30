Turbulence::Application.routes.draw do

  resources :friendships

  resources :posts do
    resources :comments
  end

  post 'tokens' => 'tokens#create'
  devise_for :users
  resources :channels
  root to: "posts#index"
  
end
