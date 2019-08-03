Rails.application.routes.draw do
  root 'games#new'
  resources :games, only: [:create, :show] do
    resources :moves, only: [:create, :destroy]
    resources :moves, only: [:index], to: redirect('games/%{game_id}')
  end
end
