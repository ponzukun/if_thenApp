Rails.application.routes.draw do
  root    'standard_pages#home'
  get     '/about',   to: 'standard_pages#about'
  get     '/contact', to: 'standard_pages#contact'
  get     '/signup',  to: 'users#new'
  post    '/signup',  to: 'users#create'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  resources :users
  resources :ifthen_rules, only: %i[create destroy]
end
