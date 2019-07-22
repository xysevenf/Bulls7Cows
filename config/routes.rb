Rails.application.routes.draw do
  root 'games#new'
  resources :games, only: [:create, :show] do
    resources :moves, only: [:create, :destroy]
  end
end
