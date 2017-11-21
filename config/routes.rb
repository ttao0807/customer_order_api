Rails.application.routes.draw do
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    resources :sessions, :only => [:create, :destroy]
    resources :customers, :only => [:show, :create, :update, :destroy] do
      resources :orders, :only => [:index, :create]
    end
    get '/list', to:"query#list"
    get '/calculate', to:"query#calculate"
  end
end
