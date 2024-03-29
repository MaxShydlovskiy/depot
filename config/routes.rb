Rails.application.routes.draw do
  resources :payment_intents, only: [ :create, :confirm ]
  post '/confirm', to: 'payment_intents#confirm'
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/create'
  get 'sessions/destroy'

  resources :support_requests, only: [ :index, :update ]

  scope '(:locale)' do
    resources :users
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index'
  end
  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
