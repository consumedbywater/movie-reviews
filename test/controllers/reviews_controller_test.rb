require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
   test "should get index" do
     get '/reviews'
     assert_response :success
   end

   test "should get new" do
     get '/movies/1/Title/reviews/new'
     assert_response :success
   end

   test "should create review without comment" do
    assert_difference('Review.count') do
      post '/reviews', params: { review: {email: 'email@email.com', movie_id: 1, movie_title: 'Some Title', rating: 4} }
    end
   
    assert_redirected_to '/movies/1'
    assert_equal "Your review was saved", flash[:notice]
  end

  test "should create review with comment" do
    assert_difference('Review.count') do
      post '/reviews', params: { review: {email: 'email@email.com', comment: "Some comment", movie_id: 1, movie_title: 'Some Title', rating: 4} }
    end
   
    assert_redirected_to '/movies/1'
    assert_equal "Your review was saved", flash[:notice]
  end

  test "shouldn't create review with missing fields" do
    assert_no_difference('Review.count') do
      post '/reviews', params: { review: {movie_id: 1, movie_title: 'Some Title', rating: 4} }
    end
   
    assert_redirected_to '/movies/1/Some%20Title/reviews/new'
    assert_equal "There was a problem saving your review", flash[:notice]
  end
end
