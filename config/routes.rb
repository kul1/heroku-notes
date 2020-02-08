Rails.application.routes.draw do
  post ':controller(/:action(/:id))(.:format)'
  get ':controller(/:action(/:id))(.:format)'
  get '/logout' => 'sessions#destroy', :as => 'logout'
  get '/auth/failure' => 'sessions#failure'
  get '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'
  resources :password_resets
  resources :sessions
  resources :identities
  resources :users
	resources :members
  mount Ckeditor::Engine => '/ckeditor'
  root :to => 'jinda#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
