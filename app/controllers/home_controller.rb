class HomeController < ApplicationController
  def index
    #Grab most recent reviews and movies from DB to populate homepage
    @recent_reviews = Review.get_five_most_recent_reviews
    @recent_movies = Review.get_five_most_recently_reviewed_movies
  end

  def about
  end
end