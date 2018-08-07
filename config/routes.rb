Rails.application.routes.draw do
  post 'refresh', controller: :refresh, action: :create
  post 'signup', controller: :signup, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signin', controller: :singin, action: :destroy
end
