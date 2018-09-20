class MoviesController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @movie_id = params[:id]
    @reviews = Review.where(:movie_id => @movie_id)
  end

  def rating
    render plain: Review.get_average_rating(params[:id])
  end

  def reviews
    render :json => {:reviews => Review.where(:movie_id => params[:id]).order('created_at desc').limit(3)}
  end
end
