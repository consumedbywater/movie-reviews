class Review < ApplicationRecord
    #Make sure we can't create a review without email, rating, or movie
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
    validates :movie_id, numericality: true

    #Get The five most recently reviewed movies in DB
    def self.get_five_most_recently_reviewed_movies
        movies = Review.select('MAX(created_at) as created_at, movie_title, movie_id, avg(rating) as rating').group(:movie_id, :movie_title).order("created_at desc").limit(5)

        return movies
    end

    #Get the five most recent reviews with comments in DB
    def self.get_five_most_recent_reviews
        reviews = Review.where("comment <> ''").limit(5).order('created_at desc')
        
        return reviews
    end

    #Get a movie's average rating by id
    def self.get_average_rating(id)
        rating = Review.where('movie_id = ?', id).average(:rating)
        return rating
    end

end
