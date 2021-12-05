Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :friends
  resources :exchanges
  get 'home/home_page'
  get 'home/dashboard'
  resources :books do
    resources :reviews
    post 'list', to: 'books#list'
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'omniauth', 
    confirmations: 'users/confirmations'
  }
  resources :users, only: [:index, :show]
  get 'my_books/:user_id', to: 'books#my_books', as: 'my_books'
  root 'home#dashboard'
  post 'follow/:friend_id', to: 'users#follow', as: 'users_follow'
  delete 'delete/:book_id', to: 'books#destroy', as: 'destroy_book'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
