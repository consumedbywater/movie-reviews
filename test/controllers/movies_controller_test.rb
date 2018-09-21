require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
   test "should get index" do
     get '/movies'
     assert_response :success
   end

   test "should get show" do
     get '/movies/1'
     assert_response :success
   end

   test "should get rating" do
    get '/movies/1/rating', xhr: true
    assert_response :success
    assert_equal 'text/plain', @response.content_type
   end

   test "should get reviews" do
    get '/movies/1/reviews', xhr: true
    assert_response :success
    assert_equal 'application/json', @response.content_type
   end
end
