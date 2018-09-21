require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  test "navigation between main pages" do
    visit '/'

    click_link('Movies')
    
    assert_current_path movies_path

    click_link('Reviews')
    
    assert_current_path reviews_path

    click_link('About')
    
    assert_current_path about_path

    click_link('Home')
    
    assert_current_path home_index_path
  end

  test "view all reviews" do
    visit '/'

    click_link('View All Reviews')

    assert_current_path reviews_path
  end

  test "view all movies" do
    visit '/'

    click_link('View All Movies')

    assert_current_path movies_path
  end

  #As different movies are added to the database, this test may need to be adjusted
  #It relies on the first page of results for Avengers containing Avengers:Infinity War
  test "search by movie" do
    visit '/movies'
    fill_in 'Movie Title', with: 'Avengers'
    click_on 'Search'

    assert page.has_content?('Avengers: Infinity War')
  end

  #As different movies are added to the database, this test may need to be adjusted
  #It relies on the first result for Solo: A Star Wars Story being the movie with ID 348350
  test "redirected back to new page without email or rating" do
    visit '/movies'
    fill_in 'Movie Title', with: 'Solo: A Star Wars Story'
    click_on 'Search'

    click_on 'Write A Review'
    assert page.has_content?('Write A Review')

    fill_in 'Email', with: 'someemail@email.com'
    click_on 'Add Post'

    assert_current_path new_movie_review_path(movie_id: 348350, movie_title: "Solo: A Star Wars Story")
    
    fill_in 'Email', with: ''
    choose 'Five Stars'
    click_on 'Add Post'

    assert_current_path new_movie_review_path(movie_id: 348350, movie_title: "Solo: A Star Wars Story")

    fill_in 'Email', with: 'fakeemail'
    choose 'Five Stars'
    click_on 'Add Post'

    assert_current_path new_movie_review_path(movie_id: 348350, movie_title: "Solo: A Star Wars Story")
  end
  
  #As different movies are added to the database, this test may need to be adjusted
  #It relies on the first result for Solo: A Star Wars Story being the movie with ID 348350
  test "write a review for Solo A Star Wars Story" do
    visit '/movies'
    fill_in 'Movie Title', with: 'Solo: A Star Wars Story'
    click_on 'Search'

    assert page.has_content?('Solo: A Star Wars Story')
    click_on 'Write A Review'
    assert_current_path new_movie_review_path(movie_id: 348350, movie_title: "Solo: A Star Wars Story")
    assert page.has_content?('Solo: A Star Wars Story')

    fill_in 'Email', with: "someemail@email.com"
    fill_in 'Comment', with: "This is a comment"
    choose 'Five Stars'
    
    click_on 'Add Post'

    assert_current_path movie_path(348350)
    assert page.has_content?('"This is a comment" - someemail@email.com')
  end
end
