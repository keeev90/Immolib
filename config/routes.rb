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
    get 'candidate_details', to: 'properties#show_candidate_details', as: 'candidate_details'
    resources 'property_pictures', only: [:create, :destroy]
    resources 'slots' do
      get 'candidate_details', to: 'slots#show_candidate_details', as: 'candidate_details'
    end
    member do
      #new candidate process
      get 'go-visit', to: "new_candidates#welcome_candidate"
      get 'step-1', to: "new_candidates#step1_login"
      get 'step1', to: "new_candidates#step1_logout"
      get 'step-2', to: "new_candidates#step2"
      get 'step-3', to: "new_candidates#step3"
    end
  end

  resources 'appointments', only: [:create, :show, :destroy] do
    resources 'candidate_slots', only: [:update, :destroy]
    resources 'candidate_messages', only: [:edit, :update, :destroy]
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
