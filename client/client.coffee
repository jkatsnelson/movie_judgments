Template.facebook.events
  'click input' : () ->
    Meteor.call 'get_access_token', (error, accessToken) ->
      throw error if error
      create_movie_list accessToken

create_movie_list = (token) ->
  Meteor.http.get 'https://graph.facebook.com/me/movies?access_token='+token, (err, result) ->
    throw err if err
    list = []
    _.each result.data.data, (like) ->
      if like.category is "Movie"
        list.push like.name
    Meteor.call 'rate_list', list, (error, result) ->
      analyze_user result

analyze_user = (movies) ->
  judge_user movies
  build_graphic movies
  suggest_movies movies

suggest_movies = (movies) ->
  Meteor.call 'suggest', movies, (error, result) ->
    console.log result
    Session.set 'movie_suggestions', result

build_graphic = (movies) ->
  data = _.map movies, (movie) ->
    'audience' : movie.ratings.audience_score
    'critics' : movie.ratings.critics_score
    'name' : movie.title
  Session.set 'd3_data', data

judge_user = (movies) ->
  audience_score = 0
  critics_score = 0
  _.each movies, (movie) ->
    audience_score += movie.ratings.audience_score
    critics_score += movie.ratings.critics_score
  audience_avg = audience_score / movies.length
  critics_avg = critics_score / movies.length
  Session.set 'scores', [audience_avg, critics_avg]
