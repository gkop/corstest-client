class SimpleCorsHttpsTest extends Test
  constructor: ->
    super
    @display_name = "Simple CORS over HTTPS"

  run: ->
    [a, b] = super

    @$http(
      method: "GET"
      url: "https://corstest-api.coshx.com:4001/tests/simple_cors?a=#{a}&b=#{b}"
    ).success((data, status, headers, config) =>
      if data.sum == a+b
        @result = "passed"
      else
        @result = "failed"
    ).error (data, status, headers, config) =>
      @result = "failed"

CorsTest.all_tests.push(SimpleCorsHttpsTest)
