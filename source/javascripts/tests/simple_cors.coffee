class SimpleCorsTest extends Test
  constructor: ->
    super
    @display_name = "Simple CORS"

  run: ->
    [a, b] = super

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
