Rails.application.routes.draw do
  root 'games#new'
  resources :players do
    # resources :games
  end
  resources :games do
    resources :moves, only: :create
  end
  get 'game_test', to: 'games#test_average'
end
