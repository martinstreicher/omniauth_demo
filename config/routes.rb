Zenask::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations' } 
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'    
  root :to => 'authentications#index'
end
