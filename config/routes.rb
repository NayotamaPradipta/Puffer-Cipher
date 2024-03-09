Rails.application.routes.draw do
  get 'kripto/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  post 'kripto/process_kripto', to: 'kripto#process_kripto', as: 'process_kripto'
  get 'kripto/process_kripto', to: 'kripto#index'
  get 'download_result', to: 'kripto#download_result'
  # Defines the root path route ("/")
  # root "posts#index"
  root 'kripto#index'
end