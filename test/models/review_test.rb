require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test "post without email" do
    review = Review.new(:rating => 4, :movie_id => 1)

    assert_not review.save, "Posted review without email"

    review = Review.new(:comment => "Hi", :rating => 4, :movie_id => 1)

    assert_not review.save, "Posted commented review without email"
  end

  test "post with invalid email" do
    review = Review.new(:email => "someinvalidemail", :rating => 4, :movie_id => 1)

    assert_not review.save, "Posted review with bad email"

    review = Review.new(:email => "someotherinvalidemail", :comment => "Hi", :rating => 4, :movie_id => 1)

    assert_not review.save, "Posted commented review with bad email"

    review = Review.new(:email => "afakeemailwithanatsymbol@", :comment => "Hi", :rating => 4, :movie_id => 1)

    assert_not review.save, "Posted commented review with bad email"

    review = Review.new(:email => "afakeemailwith@multiple@symbols", :comment => "Hi", :rating => 4, :movie_id => 1)

    assert_not review.save, "Posted commented review with bad email"

    review = Review.new(:email => "afakeemailwithSQL@problems'", :comment => "Hi", :rating => 4, :movie_id => 1)

    assert_not review.save, "Posted commented review with bad email"
  end

  test "post without rating" do
    review = Review.new(:email => "hi@hi.com", :movie_id => 1)

    assert_not review.save, "Posted review without rating"

    review = Review.new(:email => "hi@hi.com", :comment => "Hi", :movie_id => 1)

    assert_not review.save, "Posted commented review without rating"
  end

  test "post with invalid rating" do
    review = Review.new(:email => "hi@hi.com", :comment => "Hi", :rating => -1, :movie_id => 1)

    assert_not review.save, "Posted review with invalid rating"

    review = Review.new(:email => "hi@hi.com", :comment => "Hi", :rating => 7, :movie_id => 1)

    assert_not review.save, "Posted commented review with invalid rating"

    review = Review.new(:email => "hi@hi.com", :comment => "Hi", :rating => 0, :movie_id => 1)

    assert_not review.save, "Posted commented review with invalid rating"

    review = Review.new(:email => "hi@hi.com", :comment => "Hi", :rating => 3.5, :movie_id => 1)

    assert_not review.save, "Posted commented review with invalid rating"
  end

  test "post without movie" do
    review = Review.new(:email => "hi@hi.com", :rating => 4)

    assert_not review.save, "Posted review without movie"

    review = Review.new(:email => "hi@hi.com", :comment => "Hi", :rating => 4)

    assert_not review.save, "Posted commented review without movie"
  end

  test "post with invalid movie" do
    review = Review.new(:email => "hi@hi.com", :comment => "Hi", :rating => -1, :movie_id => "hi")

    assert_not review.save, "Posted review with invalid movie"
  end

  test "get review by id" do
    review_id = Review.first.id

    review = Review.find(review_id)

    assert_not_nil review.email, "Got back a review with no email"
    assert_not_nil review.rating, "Got back a review with no rating"
    assert_not_nil review.created_at, "Got back a review with no date"
    assert_not_nil review.movie_id, "Got back a review with no movie"
  end

  test "post" do
    review = Review.new(:email => "hi@hi.com", :rating => 4, :movie_id => 1)
    review.save

    commented_review = Review.new(:email => "hi@hi.com", :comment => "Hi", :rating => 3, :movie_id => 1)
    commented_review.save

    retrieved_review = Review.find(review.id)
    retrieved_commented_review = Review.find(commented_review.id)

    assert retrieved_review.email == "hi@hi.com", "Posted review with wrong email"
    assert retrieved_review.rating == 4, "Posted review with wrong rating"
    assert retrieved_review.movie_id == 1, "Posted review with wrong movie"

    assert retrieved_commented_review.email == "hi@hi.com", "Posted commented review with wrong email"
    assert retrieved_commented_review.rating == 3, "Posted commented review with wrong rating"
    assert retrieved_commented_review.movie_id == 1, "Posted commented review with wrong movie"
    assert retrieved_commented_review.comment == "Hi", "Posted commented review with wrong comment"

    review = Review.create(:email => "hi@hi.com", :rating => 4, :movie_id => 2)

    commented_review = Review.create(:email => "hi@hi.com", :comment => "Hi", :rating => 3, :movie_id => 2)
    
    retrieved_review = Review.find(review.id)
    retrieved_commented_review = Review.find(commented_review.id)

    assert retrieved_review.email == "hi@hi.com", "Posted review with wrong email"
    assert retrieved_review.rating == 4, "Posted review with wrong rating"
    assert retrieved_review.movie_id == 2, "Posted review with wrong movie"

    assert retrieved_commented_review.email == "hi@hi.com", "Posted commented review with wrong email"
    assert retrieved_commented_review.rating == 3, "Posted commented review with wrong rating"
    assert retrieved_commented_review.movie_id == 2, "Posted commented review with wrong movie"
    assert retrieved_commented_review.comment == "Hi", "Posted commented review with wrong comment"
  end

  test "get reviews ordered by most recent" do
    reviews = Review.order(:created_at)

    first_review = nil

    #Make sure reviews are ordered in descending creation date
    reviews.each do |review|
      if first_review == nil
        first_review = review
      else
        assert first_review.created_at >= review.created_at, "Reviews not in created order"
        first_review = review
      end
    end
  end

  test "get reviews by movie" do
    #Make some reviews and make sure we find them in our movie
    review = Review.create(:email => "hi@hi.com", :comment => "Hi", :rating => 3, :movie_id => 3)
    second_review = Review.create(:email => "hello@hi.com", :comment => "Hello", :rating => 4, :movie_id => 3)

    first_review_found = false
    second_review_found = false

    reviews = Review.where(:movie_id => 3)

    reviews.each do |database_review|
      if database_review == review
        first_review_found = true
      elsif database_review == second_review
        second_review_found = true
      end
    end

    assert first_review_found, "Didn't find first movie#3 review"
    assert second_review_found, "Didn't find second movie#3 review"

    #Make sure we don't find the reviews in another movie
    star_wars_reviews = Review.where(:movie_id => 4)

    first_review_found = false
    second_review_found = false

    star_wars_reviews.each do |database_review|
      if database_review == review
        first_review_found = true
      elsif database_review == second_review
        second_review_found = true
      end
    end

    assert_not first_review_found, "Found first movie#3 review in movie#4"
    assert_not second_review_found, "Found second movie#3 review in movie#4"
  end

  test "get five most recent reviews with comments" do
    #Add 8 reviews to db
    Review.create(:email => "one@one.com", :comment => "one", :rating => 1, :movie_id => 11)
    Review.create(:email => "two@two.com", :comment => "two", :rating => 1, :movie_id => 12)
    Review.create(:email => "three@three.com", :comment => "three", :rating => 1, :movie_id => 13)
    Review.create(:email => "four@four.com", :comment => "four", :rating => 1, :movie_id => 14)
    Review.create(:email => "five@five.com", :comment => "five", :rating => 1, :movie_id => 15)
    Review.create(:email => "no@no.com", :rating => 1, :movie_id => 16)
    Review.create(:email => "no@no.com", :comment => "", :rating => 1, :movie_id => 17)
    reviews = Review.get_five_most_recent_reviews
    assert reviews.length <= 5, "Got more than 5 reviews back"

    #We don't want the empty comment reviews from no@no.com
    #We do want the reviews from one@one.com, two@two.com, three@three.com, four@four.com, five@five.com

    contains_one = false
    contains_two = false
    contains_three = false
    contains_four = false
    contains_five = false

    reviews.each do |review|
      if review.email == "one@one.com"
        contains_one = true
      elsif review.email == "two@two.com"
        contains_two = true
      elsif review.email == "three@three.com"
        contains_three = true
      elsif review.email == "four@four.com"
        contains_four = true
      elsif review.email == "five@five.com"
        contains_five = true
      elsif review.email == "no@no.com"
        flunk "Got a review with empty string"
      end
    end

    assert contains_one, "Didn't get review from one"
    assert contains_two, "Didn't get review from two"
    assert contains_three, "Didn't get review from three"
    assert contains_four, "Didn't get review from four"
    assert contains_five, "Didn't get review from five"
  end

  test "get five most recently reviewed movies" do
    #Add 7 movies w reviews to db
    Review.create(:email => "one@one.com", :comment => "one", :rating => 1, :movie_id => 11)
    Review.create(:email => "two@two.com", :comment => "two", :rating => 1, :movie_id => 12)
    Review.create(:email => "three@three.com", :comment => "three", :rating => 1, :movie_id => 13)
    Review.create(:email => "four@four.com", :comment => "four", :rating => 1, :movie_id => 14)
    Review.create(:email => "five@five.com", :comment => "five", :rating => 1, :movie_id => 15)
    Review.create(:email => "six@six.com", :comment => "six", :rating => 1, :movie_id => 16)
    Review.create(:email => "seven@seven.com", :comment => "seven", :rating => 1, :movie_id => 17)

    #add two more reviews to first and second movie
    Review.create(:email => "eight@eight.com", :comment => "eight", :rating => 3, :movie_id => 11)
    Review.create(:email => "nine@nine.com", :comment => "nine", :rating => 5, :movie_id => 12)

    movies = Review.get_five_most_recently_reviewed_movies
    #We should have movies 15, 16, 17, 11, 12, with ratings 1, 1, 1, 2, 3

    assert movies.length <= 5, "Got more than 5 movies"
    
    contains_eleven = false
    contains_twelve = false
    contains_fifteen = false
    contains_sixteen = false
    contains_seventeen = false

    movies.each do |movie|
      if movie.movie_id == 11 and movie.rating == 2
        contains_eleven = true
      elsif movie.movie_id == 12 and movie.rating == 3
        contains_twelve = true
      elsif movie.movie_id == 15 and movie.rating == 1
        contains_fifteen = true
      elsif movie.movie_id == 16 and movie.rating == 1
        contains_sixteen = true
      elsif movie.movie_id == 17 and movie.rating == 1
        contains_seventeen = true
      end
    end

    assert contains_eleven, "Missing Movie#11"
    assert contains_twelve, "Missing Movie#12"
    assert contains_fifteen, "Missing Movie#15"
    assert contains_sixteen, "Missing Movie#16"
    assert contains_seventeen, "Missing Movie#17"
  end

  test "get average rating by movie" do
    Review.create(:email => "one@one.com", :comment => "one", :rating => 1, :movie_id => 21)
    Review.create(:email => "one@one.com", :comment => "one", :rating => 3, :movie_id => 21)
    Review.create(:email => "one@one.com", :comment => "one", :rating => 5, :movie_id => 21)

    rating = Review.get_average_rating(21)
    assert rating == 3, "Got average rating of " + rating.to_s

  end
end
