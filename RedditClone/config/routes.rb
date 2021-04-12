Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :new, :index, :show]

  resource :session, only: [:create, :new, :destroy]
  resources :subs 
  resources :posts, except: [:index]
end
