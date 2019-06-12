Rails.application.routes.draw do
  root 'games#new'
  resources :players do
    # resources :games
  end
  resources :games do
    resources :moves, only: :create
  end

end
