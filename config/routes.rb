Rails.application.routes.draw do
  root 'home#index'

  get 'home/index'

  get 'home/about'

  get 'movies/:id/rating', to: 'movies#rating'

  get 'movies/:id/reviews', to: 'movies#reviews'

  get 'movies/:movie_id/:movie_title/reviews/new', to: 'reviews#new', as: :new_movie_review

  resources :movies, only: [:index, :show]
  
  resources :reviews, only: [:index, :create]
end
