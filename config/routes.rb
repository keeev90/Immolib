Rails.application.routes.draw do
  get 'links/show'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/s/:slug', to: 'links#show', as: :short

end
