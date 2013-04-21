Template.facebook.events
  'click input' : () ->
    Meteor.call 'get_access_token', (error, accessToken) ->
      throw error if error
      console.log accessToken
      create_movie_list accessToken

Template.main.scores = ->
  Session.get 'scores'

Template.critics.score = ->
  scores = Session.get 'scores'
  scores[1]

Template.audience.score = ->
  scores = Session.get 'scores'
  scores[0]
Template.critics.judge = ->
  scores = Session.get 'scores'
  if scores[1] > 90
    return "Your taste isn't bad according to the critics, actually."
  if scores[1] > 80
    return "Critics generally think you have good taste."
  if scores[1] > 70
    return "You are barely passing with the experts, but passing nonetheless."
  if scores[1] > 60
    return "Your taste kinda sucks, according to the experts."

Template.audience.judge = ->
  scores = Session.get 'scores'
  if scores[0] > 90
    return "The masses are with you."
  if scores[0] > 80
    return "You've got some standard American tastes"
  if scores[0] > 70
    return "The people barely agree with you."
  if scores[0] > 60
    return "You must be a hipster-- must people don't like the movies you like."


create_movie_list = (token) ->
  Meteor.http.get 'https://graph.facebook.com/me/movies?access_token='+token, (err, result) ->
    throw err if err
    list = []
    _.each result.data.data, (like) ->
      if like.category is "Movie"
        list.push like.name
    Meteor.call 'rate_list', list, (error, result) ->
      judge_user result

judge_user = (ratings) ->
  audience_score = 0
  critics_score = 0
  _.each ratings, (movie, memo) ->
    audience_score += movie.audience_score
    critics_score += movie.critics_score
  audience_avg = audience_score / ratings.length
  critics_avg = critics_score / ratings.length
  Session.set 'scores', [audience_avg, critics_avg]



