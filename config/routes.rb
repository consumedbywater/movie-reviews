Rails.application.routes.draw do
  root 'home#index'

  get 'home/index'

  get 'about', to: 'home#about', as: :about

  get 'movies/:id/rating', to: 'movies#rating', as: :movie_rating

  get 'movies/:id/reviews', to: 'movies#reviews', as: :movie_reviews

  get 'movies/:movie_id/:movie_title/reviews/new', to: 'reviews#new', as: :new_movie_review

  resources :movies, only: [:index, :show]
  
  resources :reviews, only: [:index, :create]
end
