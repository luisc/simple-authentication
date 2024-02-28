Rails.application.routes.draw do

  resource :session
  resource :registration
  resource :password_reset
  resource :password

  # Defines the root path route ("/")
  root "main#index"
end
