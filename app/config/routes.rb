Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :absences, only: [:index, :create]
    end
  end
end
