Rails.application.routes.draw do
  root 'start_page#greeting', as: :greeting
  resources :players do
    # resources :games
  end
  resources :games

end
