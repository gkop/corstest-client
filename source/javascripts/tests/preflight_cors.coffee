class PreflightCorsTest extends Test
  constructor: ->
    super
    @display_name = "Preflight CORS"
    @url = "http://corstest-api.coshx.com:4000/tests/preflight_cors"

  run: ->
    [a, b] = super

    @$http(
      method: "POST"
      url: @url
      headers: {"x-a": a, "x-b": b}
    ).success((data, status, headers, config) =>
      if data.sum == a+b
        @result = "passed"
      else
        @result = "failed"
    ).error (data, status, headers, config) =>
      @result = "failed"

CorsTest.all_tests.push(PreflightCorsTest)

class PreflightCorsHttpsTest extends PreflightCorsTest
  constructor: ->
    super
    @display_name = "Preflight CORS over HTTPS"
    @url = @url.replace("http", "https").replace("4000", "4001")

CorsTest.all_tests.push(PreflightCorsHttpsTest)
