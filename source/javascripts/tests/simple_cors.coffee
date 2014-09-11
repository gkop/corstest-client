class SimpleCorsTest
  constructor: ($http) ->
    @result = "pending"
    @display_name = "Simple CORS"
    @$http = $http

  run: (callback) ->
    @$http(
      method: "GET"
      url: "http://corstest-api.coshx.com:3000"
    ).success((data, status, headers, config) =>
      @result = "passed"
      callback(@) if callback
    ).error (data, status, headers, config) =>
      @result = "failed"
      callback(@) if callback

CorsTest.all_tests.push(SimpleCorsTest)
