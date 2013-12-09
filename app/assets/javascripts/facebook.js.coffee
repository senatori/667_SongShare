jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init(appId: '173123302892053', cookie: true)
  window.close()

  $('#sign_in').click (e) ->
    e.preventDefault()
    window.open("/auth/facebook", width=200,height=100)