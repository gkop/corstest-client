class PreflightCorsTest extends Test
  constructor: ->
    super
    @display_name = "Preflight CORS"

  run: ->
    [a, b] = super

    @$http(
      method: "POST"
      url: "http://corstest-api.coshx.com:4000/tests/preflight_cors"
      headers: {"x-a": a, "x-b": b}
    ).success((data, status, headers, config) =>
      if data.sum == a+b
        @result = "passed"
      else
        @result = "failed"
    ).error (data, status, headers, config) =>
      @result = "failed"

CorsTest.all_tests.push(PreflightCorsTest)
