Rails.application.routes.draw do
  root 'home#index'

  resource :session, only: %i(new destroy)
end
