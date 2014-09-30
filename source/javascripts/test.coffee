class @Test
  constructor: ($http, callback) ->
    @$http = $http
    @callback = callback
    @result = "not run"

  run: ->
    @result = "pending"
    [
      Math.floor((Math.random() * 100000) + 1),
      Math.floor((Math.random() * 100000) + 1)
    ]
