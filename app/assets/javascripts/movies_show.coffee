genreArray = []

$(document).on "turbolinks:load", ->
    movieId = $('#movie-show-id').attr('movie')
    $.ajax(url: 'https://api.themoviedb.org/3/movie/' + movieId + '?api_key=5905cc7f31ec80e913b752877bc11fa2&language=en-US').done (movie) ->
        insertMovieShowPage movie, ->

insertMovieShowPage =(movie, cb) ->
    console.log(movie)
    insertMovieWithGenreNames(movie.title, movie.id, movie.poster_path, movie.genres, movie.release_date)
    insertRatingShowPage(movie.id)
    
insertRatingShowPage =(id) ->
    $.ajax(url: '/movies/' + id + '/rating').done (rating) ->
        $('#rating-show-id-' + id).empty()
        for i in [1..5]
            if rating >= i
                $('#rating-show-id-' + id).append('<img src="/assets/star-filled-white-91ffa089f753e699bbcabe2ae0fe37efc2e352e927574fc76a4d1f8586b2b077.png" alt="Star filled white" width="30" height="30" />')
            else
                $('#rating-show-id-' + id).append('<img src="/assets/star-empty-white-4cdeb573705d48549b6549c448328e1284a2babd58b83f7df28ca72275a2123e.png" alt="Star empty white" width="30" height="30" />')

insertMovieWithGenreNames =(title, id, poster, genres, release) ->
    html = '<div class="card text-white bg-dark mt-2">' +
             '<div class="row">' +
                 '<div class="col-2"></div>' +
                 '<div class="col-4 py-4">' +
                     '<img src="https://image.tmdb.org/t/p/w200' + poster + '" width="165"/>' +
                 '</div>' +
                 '<div class="col-4">' +
                     '<div class="card-body">' +
                         '<h4>' + title + '</h4>' +
                         
                     '<div class="pb-3" id="rating-show-id-' + id + '"></div>' +
                        '<p class="card-text">' +
                        'Release date: ' + release  + 
                        '<br />' +
                        'Genres: ' + createGenreListWithNames(genres) +
                        '</p>' +
                        '<a class="text-white" href="/movies/' + id + '/' + title + '/reviews/new">Write A Review</a>' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>'
    $('#movie-show-id').append(html)

createGenreListWithNames =(genres) ->
    genreList = ""
    for genre in genres
        genreList = genreList + genre.name + ' | '
    return genreList