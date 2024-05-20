Rails.application.routes.draw do
  # Route for showing the login form
  get 'login', to: 'sessions#new', as: 'login'
  # Route for posting the login form
  post 'login', to: 'sessions#create'
  # Route for logging out
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create]
  
  resources :schedules, only: [:index, :new, :create]
  # Correctly define the route for deleting schedules by criteria
  delete 'schedules/delete_by_criteria', to: 'schedules#delete_by_criteria', as: 'delete_schedule_by_criteria'

  root to: 'schedules#index'
end




