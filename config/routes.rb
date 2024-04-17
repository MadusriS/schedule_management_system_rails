Rails.application.routes.draw do
  resources :schedules, only: [:index, :new, :create, :destroy]
  root to: 'schedules#index'
end

