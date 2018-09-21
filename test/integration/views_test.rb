require 'test_helper'

class ViewsTest < ActionDispatch::IntegrationTest
    test "can see homepage" do
        get '/'
        assert_select 'h1', 'Movie Spotlight'
    end

    test "can see movies page" do
        get '/movies'
        assert_select 'h1', 'Movie Search'
    end

    test "can see reviews page" do
        get '/reviews'
        assert_select 'h1', 'Reviews'
    end

    test "can see about page" do
        get '/about'
        assert_select 'h1', 'About'
    end

    test "can see new review page" do
        get '/movies/1/Title/reviews/new'
        assert_select 'h1', 'Write A Review'
    end

    test "can write new review" do
        get '/movies/1/Title/reviews/new'
        assert_response :success

        post "/reviews", params: {review: {email: "email@email.testing", rating: 5, movie_id: 1, movie_title: "Title"}}

        assert_response :redirect
        assert_redirected_to '/movies/1'
        follow_redirect!
        assert_response :success
        assert_select "p", "email@email.testing"
    end
end