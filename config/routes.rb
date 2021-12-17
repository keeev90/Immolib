Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'

  get "welcome_user", to: "static_pages#welcome_user"
  get "faq", to: "static_pages#faq"

  resources 'users' do
    resources 'profile_pictures', only: [:create, :destroy]
  end

  resources 'properties' do 
    resources 'property_pictures', only: [:create, :destroy]
    resources 'slots' do
      get 'candidate_details', to: 'slots#show_candidate_details', as: 'candidate_details'
    end
    member do
      #user new appointment process
      get 'go-visit', to: "properties#welcome_candidate"
      get 'book-now', to: "slots#book_candidate"
      get 'book', to: "slots#before_book_candidate"
      get 'send-message', to: "appointments#message_candidate"
    end
  end

  resources 'appointments' do
    resources 'candidate_documents', only: [:create, :destroy]
    resources 'candidate_dossierfacile_folders', only: [:create, :destroy]
    resources 'candidate_dossierfacile_links', only: [:create, :destroy]
  end

  scope '/checkout' do
    resources 'checkout', only: [:create]
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  namespace :admin do
    root 'welcome#index'
  end

end
