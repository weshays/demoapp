require 'resque/server'

Rails.application.routes.draw do
  mount Resque::Server.new, at: '/jobs'
  # mount ActionCable.server => '/cable'

  root to: proc { [404, {}, ['Not found']] }

  defaults format: :json do
    namespace :api do
      get 'me', to: 'sessions#show'
      post 'login', to: 'sessions#create'
    end
  end
end
