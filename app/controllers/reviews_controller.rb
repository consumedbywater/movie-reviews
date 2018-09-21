class ReviewsController < ApplicationController
  def index
    #Grab all reviews to populate page
    @reviews = Review.order('created_at desc')
  end

  def new
    #Get movie_id, title, and new Review for new page
    @movie_id = params[:movie_id]
    @movie_title = params[:movie_title]
    @review = Review.new
  end

  def create
    #Using returned parameters, create a new review
    @review = Review.new(params.require(:review).permit(:email, :rating, :comment, :movie_id, :movie_title))

    #If review was saved, send to Movie path with proper notice
    #Otherwise, send back to new movie path with proper notice
    if @review.save
      flash[:primary] = "Your review was saved"
      redirect_to movie_path(@review.movie_id)
    else
      flash[:warning] = "There was a problem saving your review"
      redirect_to new_movie_review_path(:movie_id => @review.movie_id, :movie_title => @review.movie_title)
    end
  end
end
