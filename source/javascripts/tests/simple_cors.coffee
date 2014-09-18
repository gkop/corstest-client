class SimpleCorsTest
  constructor: ($http) ->
    @result = "pending"
    @display_name = "Simple CORS"
    @$http = $http

  run: ->
    a = Math.floor((Math.random() * 100000) + 1)
    b = Math.floor((Math.random() * 100000) + 1)
    @$http(
      method: "GET"
      url: "http://corstest-api.coshx.com:4000/tests/simple_cors?a=#{a}&b=#{b}"
    ).success((data, status, headers, config) =>
      if data.sum == a+b
        @result = "passed"
      else
        @result = "failed"
    ).error (data, status, headers, config) =>
      @result = "failed"

CorsTest.all_tests.push(SimpleCorsTest)
