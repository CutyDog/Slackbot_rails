Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "hello", to: 'application#hello'
  get "name", to: 'application#name'
  get "love", to: 'application#love'

  get "/"=>"slack#index"
  post "/receive"=>"slack#create"
end
