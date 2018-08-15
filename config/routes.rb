Rails.application.routes.draw do
  resources :ads
  post   'refresh',   controller: :refresh,  action: :create
  post   'signup',    controller: :signup,   action: :create
  post   'signin',    controller: :signin,   action: :create
  delete 'signin',    controller: :signin,   action: :destroy
  get    'me',        controller: :users,    action: :me
end
