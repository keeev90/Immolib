Rails.application.routes.draw do
  get 'slots/index'
  get 'slots/show'
  get 'slots/new'
  get 'slots/create'
  get 'slots/edit'
  get 'slots/update'
  get 'slots/destroy'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'
  resources 'users'
  resources 'properties' do 
    resources 'slots'
  end 
  resources 'appointments', except: [:edit, :update]

end
