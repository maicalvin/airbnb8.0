Rails.application.routes.draw do

  get 'braintree/new'

  resources :listings do
    resources :reservations
    collection do
      get:search
      get:price_desc
      get:price_asc
      get:search_ajax

    end
  end
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end
  post '/listings/:listing_id/reservations/:id/checkout'=>'reservations#checkout', as: "reservation_payment"


  get"/users/:id"=>"users#show",as: "user_show"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  root "listings#index"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  resources :posts
  root to: 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
