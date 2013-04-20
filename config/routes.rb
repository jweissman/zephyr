Zephyr::Application.routes.draw do
  # star resources
  resources :stars do
    collection do
      get 'destroy_all'
    end
  end

  # temporary root at sandbox page
  root to: 'pages#root'

  # demos
  match 'lobby' => 'pages#lobby', as: :lobby
  match 'games' => 'pages#games', as: :games
  match 'pong'  => 'pages#pong',  as: :pong

  match 'zero'  => 'pages#zeronaut', as: :zeronaut

  # authentication stuff
  match 'sign_in'  => 'user_sessions#new',     as: :sign_in
  match 'sign_out' => 'user_sessions#destroy', as: :sign_out

  resources :user_sessions, only: [:new, :create, :destroy]

  match 'sign_up' => 'registrations#new',              via: :get,  as: :sign_up
  match 'sign_up' => 'registrations#create',           via: :post, as: :sign_up
  match 'activate/:token' => 'registrations#activate', via: :get,  as: :activation

  match 'forgotten_password' => 'password_resets#new',     via: :get,  as: :forgotten_password
  match 'forgotten_password' => 'password_resets#create',  via: :post, as: :forgotten_password
  match 'reset_password/:token' => 'password_resets#edit', via: :get,  as: :reset_password
  match 'reset_password/:id' => 'password_resets#update',  via: :put

  # user resource
  resources :users

end
