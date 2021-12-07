Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'


  get "welcome_user", to: "static_pages#welcome_user"
  resources 'users'
  resources 'properties' do 
    resources 'slots'
  end 
  resources 'appointments', except: [:edit, :update]

end
