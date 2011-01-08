Zenask::Application.routes.draw do
  devise_for :users do
    get 'sign_in', :to => 'devise/sessions#new'
  end

  resources :authentications

  match '/auth/:provider/callback' => 'authentications#create'  
  
  root :to => 'welcome#index'
end
