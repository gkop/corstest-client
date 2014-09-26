class SimpleCorsSpdyTest
  constructor: ($http) ->
    @result = "pending"
    @display_name = "Simple CORS over SPDY"
    @$http = $http

  run: ->
    a = Math.floor((Math.random() * 100000) + 1)
    b = Math.floor((Math.random() * 100000) + 1)
    @$http(
      method: "GET"
      url: "https://corstest-api.coshx.com:4002/?a=#{a}&b=#{b}"
    ).success((data, status, headers, config) =>
      if data.sum == a+b && data.spdy == true
        @result = "passed"
      else
        @result = "failed"
    ).error (data, status, headers, config) =>
      @result = "failed"

CorsTest.all_tests.push(SimpleCorsSpdyTest)
