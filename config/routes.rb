Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  post '/' ,to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup' ,to: 'users#new'
  resources :users, only:[:show, :edit, :create, :update, :index]
  
  resources :records, only:[:edit, :update, :new, :create, :destroy]
end
