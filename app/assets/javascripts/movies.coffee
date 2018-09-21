#Some global variables for genre population and page navigation
genreArray = []
currentPage = 0
totalPages = 0
search = ""

#Execute this when the page is finished loading
$(document).on "turbolinks:load", ->
    hideNavigation()

    #Get genres from TMDB
    $.ajax(url: 'https://api.themoviedb.org/3/genre/movie/list?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US').done (genres) ->
        genreArray = genres.genres

    #Enable clicking on different buttons
    $('#search-button').on 'click', ->
        clearMovies()
        search = encodeURI($('#search-field').val())
        currentPage = 1
        #Get movies from TMDB
        $.ajax(url: 'https://api.themoviedb.org/3/search/movie?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US&query=' + search + '&page=' + currentPage + '&include_adult=false').done (movies) ->
            totalPages = if 1000 < movies.total_pages then 1000 else movies.total_pages
            movieArray = movies.results
            showNavigation()
            insertMoviesSearch movieArray, ->
                setButtons()

    $('#first-button').on 'click', ->
        currentPage = 1
        clearMovies()
        $.ajax(url: 'https://api.themoviedb.org/3/search/movie?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US&query=' + search + '&page=' + currentPage + '&include_adult=false').done (movies) ->
            totalPages = if 1000 < movies.total_pages then 1000 else movies.total_pages
            movieArray = movies.results
            insertMoviesSearch movieArray, ->
                setButtons()

    $('#previous-button').on 'click', ->
        if currentPage > 1
            clearMovies()
            currentPage = currentPage - 1
            $.ajax(url: 'https://api.themoviedb.org/3/search/movie?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US&query=' + search + '&page=' + currentPage + '&include_adult=false').done (movies) ->
                totalPages = if 1000 < movies.total_pages then 1000 else movies.total_pages
                movieArray = movies.results
                insertMoviesSearch movieArray, ->
                    setButtons()

    $('#next-button').on 'click', ->
        if currentPage < totalPages
            clearMovies()
            currentPage = currentPage + 1
            $.ajax(url: 'https://api.themoviedb.org/3/search/movie?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US&query=' + search + '&page=' + currentPage + '&include_adult=false').done (movies) ->
                totalPages = if 1000 < movies.total_pages then 1000 else movies.total_pages
                movieArray = movies.results
                insertMoviesSearch movieArray, ->
                    setButtons()


    $('#last-button').on 'click', ->
        currentPage = totalPages
        clearMovies()
        $.ajax(url: 'https://api.themoviedb.org/3/search/movie?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US&query=' + search + '&page=' + currentPage + '&include_adult=false').done (movies) ->
            totalPages = if 1000 < movies.total_pages then 1000 else movies.total_pages
            movieArray = movies.results
            insertMoviesSearch movieArray, ->
                setButtons()

#Clear all search results
clearMovies = ->
    $('#search-results').empty()

#Show navigation buttons
showNavigation = ->
    $('#first-button').show()
    $('#previous-button').show()
    $('#current-page').show()
    $('#next-button').show()
    $('#last-button').show()

#Hide navigation buttons
hideNavigation = ->
    $('#first-button').hide()
    $('#previous-button').hide()
    $('#current-page').hide()
    $('#next-button').hide()
    $('#last-button').hide()

#Set the navigation buttons to enabled/disabled as needed
setButtons = ->
    if (currentPage <= 1)
        $('#first-button').prop('disabled', true)
        $('#previous-button').prop('disabled', true)
    else
        $('#first-button').prop('disabled', false)
        $('#previous-button').prop('disabled', false)

    if (totalPages <= currentPage)
        $('#next-button').prop('disabled', true)
        $('#last-button').prop('disabled', true)
    else
        $('#next-button').prop('disabled', false)
        $('#last-button').prop('disabled', false)
    $('#current-page').text(currentPage)

#Loop through movie array and put movies on page
insertMoviesSearch =(movieArray, cb) ->
    for movie in movieArray
        insertMovieSearch(movie.title, movie.id, movie.poster_path, movie.genre_ids, movie.release_date)
        insertRatingSearch(movie.id)
        insertReviewsSearch(movie.id, cb)

#Find section for movie rating, get rating from DB, and insert into page
insertRatingSearch =(id) ->
    $.ajax(url: '/movies/' + id + '/rating').done (rating) ->
        $('#rating-search-id-' + id).empty()
        for i in [1..5]
            if rating >= i
                $('#rating-search-id-' + id).append('<img src="/assets/star-filled-7320ff66de798d37e18a026145a6975e61dc547f79df018dc31f42df25d36da4.png" alt="Star filled" width="30" height="30" />')
            else
                $('#rating-search-id-' + id).append('<img src="/assets/star-empty-e9301878ad41c600f8959fa49c8a9b7e1b37a7df7fa0e0253b71a36bc57faceb.png" alt="Star empty" width="30" height="30" />')

#Generate an HTML string for a given rating
generateRatingSearch =(rating) ->
    ratingString = ""
    for i in [1..5]
        if rating >= i
            ratingString = ratingString + '<img src="/assets/star-filled-7320ff66de798d37e18a026145a6975e61dc547f79df018dc31f42df25d36da4.png" alt="Star filled" width="20" height="20" />'
        else
            ratingString = ratingString + '<img src="/assets/star-empty-e9301878ad41c600f8959fa49c8a9b7e1b37a7df7fa0e0253b71a36bc57faceb.png" alt="Star empty" width="20" height="20" />'
    return ratingString

#Generate an HTML string for a given comment
generateCommentSearch =(comment) ->
    if comment.length > 0
        return '"' + comment + '" - '
    else
        return ''

#Find section for reviews, get reviews from DB, and insert into page
insertReviewsSearch =(id, cb) ->
    $.ajax(url: '/movies/' + id + '/reviews').done (reviews) ->
        reviewArray = reviews.reviews
        $('#review-search-section-' + id).empty()

        for review in reviewArray      
            $('#review-search-section-' + id).append(
                '<div class="row">' +
                    '<div class="col-4">' +
                        generateRatingSearch(review.rating) +
                    '</div>' +
                    '<div class="col-8">' +
                        '<p class="card-text mb-3">' +
                        generateCommentSearch(review.comment) +
                        review.email + 
                        '</p>' +
                    '</div>' +
                '</div>')
        cb()

#Insert movie HTML into page
insertMovieSearch =(title, id, poster, genres, release) ->
    html = '<div class="card text-white bg-secondary mt-2">' +
             '<div class="row">' +
                 '<div class="col-4">' +
                     '<img src="https://image.tmdb.org/t/p/w200' + poster + '" width="165" class="pl-3 pt-3" />' +
                     '<br />' +
                     '<div class="pl-3 pb-3" id="rating-search-id-' + id + '"></div>' +
                 '</div>' +
                 '<div class="col-8">' +
                     '<div class="card-body">' +
                         '<a class="h4 text-white" href="/movies/' + id + '">' + title + '</a>' +
                        '<p class="card-text">' +
                        'Release date: ' + release  + 
                        '<br />' +
                        'Genres: ' + createGenreListSearch(genres) +
                        '</p>' +
                        '<div id="review-search-section-' + id + '"></div>' +
                        '<div class="row">' +
                            '<a class="text-white mr-3" href="/movies/' + id + '">View More Reviews</a>' +
                            '<a class="text-white" href="/movies/' + id + '/' + title + '/reviews/new">Write A Review</a>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>'
    $('#search-results').append(html)

#Create an HTML string for a list of genres
createGenreListSearch =(genres) ->
    genreList = ""
    for genreId in genres
        for genre in genreArray
            if genreId == genre.id
                genreList = genreList + genre.name + ' | '
    return genreList