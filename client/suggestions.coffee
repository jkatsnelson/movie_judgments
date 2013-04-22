Template.suggestions.movies = () ->
  if Session.get 'movie_suggestions'
    return Session.get 'movie_suggestions'
  else
    return [{'title':'The Matrix','genre':'Action'}]