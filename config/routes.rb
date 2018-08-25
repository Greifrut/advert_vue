# frozen_string_literal: true

Rails.application.routes.draw do
  resources :orders
  resources :ads
  post   'refresh',   controller: :refresh,  action: :create
  post   'signup',    controller: :signup,   action: :create
  post   'signin',    controller: :signin,   action: :create
  delete 'signin',    controller: :signin,   action: :destroy
  get    'me',        controller: :users,    action: :me
end
