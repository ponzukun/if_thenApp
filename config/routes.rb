Rails.application.routes.draw do
  root 'standard_pages#home'
  get  '/about', to: 'standard_pages#about'
  get  '/contact', to: 'standard_pages#contact'
end
