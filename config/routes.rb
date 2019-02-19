Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'user/new' => 'user#new'
  post 'user/new' => 'user#new'
  get 'user/:username/:password' => 'user#show'
  post 'user/create_negative' => 'user#create_negative'
  post 'user/create_invisible' => 'user#create_invisible'

end
