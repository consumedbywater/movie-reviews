class MoviesController < ApplicationController
  def index
    #send a list of reviews
    @reviews = Review.all
  end

  def show
    #expect parameters for movie details
    #create movie if needed
    @movie_id = params[:id]
    #send a list of reviews for movie
    @reviews = Review.where(:movie_id => @movie_id)
  end

  def rating
    render plain: Review.get_average_rating(params[:id])
  end

  def reviews
    render :json => {:reviews => Review.where(:movie_id => params[:id]).order('created_at desc').limit(3)}
  end
end
