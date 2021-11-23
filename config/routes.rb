Rails.application.routes.draw do
  resources :exchanges
  get 'home/dashboard'
  resources :books do
    post 'list', to: 'books#list'
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users, only: [:index, :show]
  root 'home#dashboard'
  delete 'delete/:book_id', to: 'books#destroy', as: 'destroy_book'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
