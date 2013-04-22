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
