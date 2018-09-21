class MoviesController < ApplicationController
  def index
  end

  def show
    #Grab reviews for given movie_id to populate page
    @movie_id = params[:id]
    @reviews = Review.where(:movie_id => @movie_id).order('created_at desc')
  end

  def rating
    #Send average rating for a movie as plaintext
    render plain: Review.get_average_rating(params[:id])
  end

  def reviews
    #Send First three reviews for a given movie ID as json
    render :json => {:reviews => Review.where(:movie_id => params[:id]).order('created_at desc').limit(3)}
  end
end
