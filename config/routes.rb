Rails.application.routes.draw do

  root 'users#home'

  # Admins routes
  get '/admins' => 'admins#index', as: 'admins'
  post '/admins' => 'admins#create'
  get '/admins/new' => 'admins#new', as: 'new_admin'
  delete '/admins/:id' => 'admins#destroy'
  get '/admins/home' => 'admins#home'
  get '/admins/account' => 'admins#account'
  post '/admins/update' => 'admins#account'

  # Users routes
  get '/users' => 'users#index', as: 'users'
  post '/users' => 'users#create'
  get '/users/new' => 'users#new', as: 'new_user'
  delete '/users/:id' => 'users#destroy'
  get '/users/home' => 'users#home'
  get '/users/account' => 'users#account'
  post '/users/account' => 'users#account'
  # Buses routes
  get '/buses' => 'buses#index', as: 'buses'
  post '/buses' => 'buses#create'
  get '/buses/new' => 'buses#new', as: 'new_bus'
  delete '/buses/:id' => 'buses#destroy'
  # Reports routes
  get '/reports' => 'reports#index', as: 'reports'
  post '/reports' => 'reports#create'
  get '/reports/new' => 'reports#new', as: 'new_report'
  delete '/reports/:id' => 'reports#destroy'
  #Admins Sessions routes
  get '/admins/login' => 'sessions#new_admin'
  post '/admins/login' => 'sessions#login_admin'
  get '/admins/logout' => 'sessions#destroy_admin'
  #Users Sessions routes
  get '/users/login' => 'sessions#new_user'
  post '/users/login' => 'sessions#login_user'
  get '/users/logout' => 'sessions#destroy_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
