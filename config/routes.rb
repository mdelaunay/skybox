Skybox::Application.routes.draw do
  root :to => "documents#index"
  resources :users
  resources :sessions
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :documents do
    resources :sheets
  end
end
