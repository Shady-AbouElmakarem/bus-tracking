Rails.application.routes.draw do

  # Admins routes
  get '/admins' => 'admins#index', as: 'admins'
  post '/admins' => 'admins#create'
  get '/admins/new' => 'admins#new', as: 'new_admin'
  patch '/admins/:id' => 'admins#update'
  put '/admins/:id' => 'admins#update'
  delete '/admins/:id' => 'admins#destroy'
  get '/admins/home' => 'admins#home'
  # Users routes
  get '/users' => 'users#index', as: 'users'
  post '/users' => 'users#create'
  get '/users/new' => 'users#new', as: 'new_user'
  patch '/users/:id' => 'users#update'
  put '/users/:id' => 'users#update'
  delete '/users/:id' => 'users#destroy'
  get '/users/home' => 'users#home'
  # Buses routes
  get '/buses' => 'buses#index', as: 'buses'
  post '/buses' => 'buses#create'
  get '/buses/new' => 'buses#new', as: 'new_bus'
  patch '/buses/:id' => 'buses#update'
  put '/buses/:id' => 'buses#update'
  delete '/buses/:id' => 'buses#destroy'
  # Reports routes
  get '/reports' => 'reports#index', as: 'reports'
  post '/reports' => 'reports#create'
  get '/reports/new' => 'reports#new', as: 'new_report'
  patch '/reports/:id' => 'reports#update'
  put '/reports/:id' => 'reports#update'
  delete '/reports/:id' => 'reports#destroy'
  #Admins Sessions routes
  get '/admins/login' => 'sessions#new'
  post '/admins/login' => 'sessions#create'
  get '/admins/logout' => 'sessions#destroy'
  #Users Sessions routes
  get '/users/login' => 'sessions#new_user'
  post '/users/login' => 'sessions#create_user'
  get '/users/logout' => 'sessions#destroy_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
