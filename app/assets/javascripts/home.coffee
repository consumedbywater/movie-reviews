genreArray = []

$(document).on "turbolinks:load", ->
    $('#genre-select').hide()
    $.ajax(url: 'https://api.themoviedb.org/3/genre/movie/list?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US').done (genres) ->
        genreArray = genres.genres
        for genre in genreArray
            $('#genre-select').append('<option value="' + genre.id + '">' + genre.name + '</option>')
        $.ajax(url: 'https://api.themoviedb.org/3/discover/movie?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1').done (movies) ->
            movieArray = movies.results
            insertMovies movieArray, ->
                $('#popularity-button').prop('disabled', true)

    $('#title-button').on 'click', ->
        $('.movie-control').prop('disabled', true);
        $.ajax(url: 'https://api.themoviedb.org/3/discover/movie?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US&sort_by=original_title.desc&include_adult=false&include_video=false&page=1').done (movies) ->
            $('#movie-cards').empty()
            $('#movie-cards').append('<div id="movie-list"></div>')
            movieArray = movies.results
            insertMovies movieArray, ->
                $('.movie-control').prop('disabled', false)
                $('#title-button').prop('disabled', true)
                $('#genre-select').hide()

    $('#release-button').on 'click', ->
        $('.movie-control').prop('disabled', true);
        $.ajax(url: 'https://api.themoviedb.org/3/discover/movie?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US&sort_by=release_date.desc&include_adult=false&include_video=false&page=1').done (movies) ->
            $('#movie-cards').empty()
            $('#movie-cards').append('<div id="movie-list"></div>')
            movieArray = movies.results
            insertMovies movieArray, ->
                $('.movie-control').prop('disabled', false)
                $('#release-button').prop('disabled', true)
                $('#genre-select').hide()

    $('#genre-button').on 'click', ->
        $('.movie-control').prop('disabled', true);
        genreNum = $('#genre-select').val()
        $.ajax(url: 'https://api.themoviedb.org/3/discover/movie?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=' + genreNum).done (movies) ->
            $('#movie-cards').empty()
            $('#movie-cards').append('<div id="movie-list"></div>')
            movieArray = movies.results
            insertMovies movieArray, ->
                $('.movie-control').prop('disabled', false)
                $('#genre-button').prop('disabled', true)
                $('#genre-select').show()

    $('#popularity-button').on 'click', ->
        $('.movie-control').prop('disabled', true)
        $.ajax(url: 'https://api.themoviedb.org/3/discover/movie?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1').done (movies) ->
            $('#movie-cards').empty()
            $('#movie-cards').append('<div id="movie-list"></div>')
            movieArray = movies.results
            insertMovies movieArray, ->
                $('.movie-control').prop('disabled', false)
                $('#popularity-button').prop('disabled', true)
                $('#genre-select').hide()

    $('#genre-select').on 'change', ->
        genreNum = $('#genre-select').val()
        $.ajax(url: 'https://api.themoviedb.org/3/discover/movie?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=' + genreNum).done (movies) ->
            $('#movie-cards').empty()
            $('#movie-cards').append('<div id="movie-list"></div>')
            movieArray = movies.results
            insertMovies movieArray, ->

insertMovies =(movieArray, cb) ->
    for movie in movieArray
        insertMovie(movie.title, movie.id, movie.poster_path, movie.genre_ids, movie.release_date)
        insertRating(movie.id)
        insertReviews(movie.id, cb)

insertRating =(id) ->
    $.ajax(url: '/movies/' + id + '/rating').done (rating) ->
        $('#rating-id-' + id).empty()
        for i in [1..5]
            if rating >= i
                $('#rating-id-' + id).append('<img src="/assets/star-filled-7320ff66de798d37e18a026145a6975e61dc547f79df018dc31f42df25d36da4.png" alt="Star filled" width="30" height="30" />')
            else
                $('#rating-id-' + id).append('<img src="/assets/star-empty-e9301878ad41c600f8959fa49c8a9b7e1b37a7df7fa0e0253b71a36bc57faceb.png" alt="Star empty" width="30" height="30" />')

generateRating =(rating) ->
    ratingString = ""
    for i in [1..5]
        if rating >= i
            ratingString = ratingString + '<img src="/assets/star-filled-7320ff66de798d37e18a026145a6975e61dc547f79df018dc31f42df25d36da4.png" alt="Star filled" width="20" height="20" />'
        else
            ratingString = ratingString + '<img src="/assets/star-empty-e9301878ad41c600f8959fa49c8a9b7e1b37a7df7fa0e0253b71a36bc57faceb.png" alt="Star empty" width="20" height="20" />'
    return ratingString

generateComment =(comment) ->
    if comment.length > 0
        return '"' + comment + '" - '
    else
        return ''

insertReviews =(id, cb) ->
    $.ajax(url: '/movies/' + id + '/reviews').done (reviews) ->
        reviewArray = reviews.reviews
        $('#review-section-' + id).empty()

        for review in reviewArray      
            $('#review-section-' + id).append(
                '<div class="row">' +
                    '<div class="col-4">' +
                        generateRating(review.rating) +
                    '</div>' +
                    '<div class="col-8">' +
                        '<p class="card-text mb-3">' +
                        generateComment(review.comment) +
                        review.email + 
                        '</p>' +
                    '</div>' +
                '</div>')
        cb()

insertMovie =(title, id, poster, genres, release) ->
    html = '<div class="card text-white bg-secondary mt-2">' +
             '<div class="row">' +
                 '<div class="col-4">' +
                     '<img src="https://image.tmdb.org/t/p/w200' + poster + '" width="165" class="pl-3 pt-3" />' +
                     '<br />' +
                     '<div class="pl-3 pb-3" id="rating-id-' + id + '"></div>' +
                 '</div>' +
                 '<div class="col-8">' +
                     '<div class="card-body">' +
                         '<a class="h4 text-white" href="/movies/' + id + '">' + title + '</a>' +
                        '<p class="card-text">' +
                        'Release date: ' + release  + 
                        '<br />' +
                        'Genres: ' + createGenreList(genres) +
                        '</p>' +
                        '<div id="review-section-' + id + '"></div>' +
                        '<div class="row">' +
                            '<a class="text-white mr-3" href="/movies/' + id + '">View More Reviews</a>' +
                            '<a class="text-white" href="/movies/' + id + '/' + title + '/reviews/new">Write A Review</a>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>'
    $('#movie-list').before(html)

createGenreList =(genres) ->
    genreList = ""
    for genreId in genres
        for genre in genreArray
            if genreId == genre.id
                genreList = genreList + genre.name + ' | '
    return genreList