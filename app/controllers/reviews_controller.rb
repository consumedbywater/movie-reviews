class ReviewsController < ApplicationController
  def index
    @reviews = Review.limit(20).order(:created_at)
  end

  def new
    @movie_id = params[:movie_id]
    @movie_title = params[:movie_title]
    @review = Review.new
  end

  def create
    @review = Review.new(params.require(:review).permit(:email, :rating, :comment, :movie_id, :movie_title))

    if @review.save
      redirect_to movie_path(@review.movie_id), :notice => "Your review was saved"
    else
      redirect_to new_movie_review_path(:movie_id => @review.movie_id, :movie_title => @review.movie_title), :notice => "There was a problem saving your review"
    end
  end
end
