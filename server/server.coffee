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
    ratings = []
    _.each list, (movie) ->
      movie_uri = movie.replace /\s/g, "%20"
      url = root_api + movie_uri + suffix_api
      Meteor.http.get url, (err, result) ->
        throw err if err
        movie_ratings = find_correct_title result.data.movies, movie
        ratings.push movie_ratings
        if ratings.length is list.length
          fut.ret ratings

    fut.wait()

find_correct_title = (film_results, movie) ->
  ratings = null
  _.each film_results, (film_result) ->
    if film_result.title is movie
      ratings = film_result.ratings
  ratings
