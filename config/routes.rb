Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'

  get "welcome_user", to: "static_pages#welcome_user"

  resources 'users' do
    resources 'profile_pictures', only: [:create, :destroy]
  end


  resources 'properties' do 
    resources 'property_pictures', only: [:create, :destroy]
    resources 'slots'
    member do
      get 'go-visit', to: "properties#show_candidate"
      get 'book-now', to: "slots#index_candidate"
      get 'first-slots', to: "slots#index_first"
      get 'first-new', to: "slots#new_first"
    end
  end 

# get '/properties/:id/test', to: "properties#show_candidate"


  resources 'appointments', except: [:edit, :update]

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

end
