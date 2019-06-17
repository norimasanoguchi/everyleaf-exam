Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :labels, only:[:index, :new, :create, :destroy]
  end
  root to: 'tasks#index'
  resources :tasks
  resources :users, only:[:new,:create,:show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks_labels, only: [:create, :destroy]
end
