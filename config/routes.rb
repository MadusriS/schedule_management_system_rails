Rails.application.routes.draw do
  resources :schedules, only: [:index, :new, :create]
  get '/schedules/delete_by_criteria', to: 'schedules#delete_by_criteria', as: 'delete_schedule_by_criteria'

  root to: 'schedules#index'
end



