Future = Npm.require 'fibers/future'

Meteor.methods
  get_access_token: () ->
    try
      return Meteor.user().services.facebook.accessToken
    catch e
      throw e
  rate_list : (list) ->
    fut = new Future()
    root_api = 'http://api.rottentomatoes.com/api/public/v1.0/movies.json?q='
    suffix_api = '&apikey=yadhkdu48t3yj6s898mdfny7'
    movie_data = []
    _.each list, (movie_name) ->
      movie_uri = movie_name.replace /\s/g, "%20"
      url = root_api + movie_uri + suffix_api
      Meteor.http.get url, (err, result) ->
        throw err if err
        correct_movie = find_correct_title result.data.movies, movie_name
        movie_data.push correct_movie
        if movie_data.length is list.length
          fut.ret movie_data

    fut.wait()

find_correct_title = (movie_list, movie_name) ->
  correct_movie = null
  _.each movie_list, (movie) ->
    if movie.title is movie_name
      correct_movie = movie
  correct_movie
