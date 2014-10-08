class PreflightCorsSpdyTest extends Test
  constructor: ->
    super
    @display_name = "Preflight CORS over SPDY"
    @url = "https://corstest-api.coshx.com:4002"

  run: ->
    [a, b] = super

    @$http(
      method: "POST"
      url: @url
      headers: {"x-a": a, "x-b": b}
    ).success((data, status, headers, config) =>
      if data.sum == a+b && data.spdy == true
        @result = "passed"
      else
        @result = "failed"
    ).error (data, status, headers, config) =>
      @result = "failed"

CorsTest.all_tests.push(PreflightCorsSpdyTest)

