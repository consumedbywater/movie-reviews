class HomeController < ApplicationController
  def index
    @recent_reviews = Review.get_five_most_recent_reviews
    @recent_movies = Review.get_five_most_recently_reviewed_movies
    @reviews = Review.all
    @movies = [Movie.new(id: 1, title: "Movie Title 1", release_date: "September 22, 2018", image_location: "star-filled.png", rating: 3, genres: ["Action", "Comedy"]),
               Movie.new(id: 2, title: "Movie Title 2", release_date: "September 3, 2017", image_location: "star-filled.png", rating: 4, genres: ["Adventure", "Science Fiction"])]
  end

  def about
  end
end