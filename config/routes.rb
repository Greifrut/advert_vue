Rails.application.routes.draw do
  post 'refresh', controller: :refresh, action: :create
end
