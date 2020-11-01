Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  get  '/home/about', to: 'homes#about'
  resources :books

  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
