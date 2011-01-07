Zenask::Application.routes.draw do
  devise_for :users do
    get "sign_in", :to => "devise/sessions#new"
  end

  resource :user
  resources :intents
  
  resources :questions do
    get :vote
  end
  
  root :to => "welcome#index"
end
