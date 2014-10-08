class EventSourceTest extends Test
  constructor: ->
    super
    @display_name = "EventSource CORS"
    @url = "http://corstest-api.coshx.com:4000/tests/eventsource"

  run: ->
    [a, b] = super
    if typeof EventSource == "undefined"
      @result = "failed"
      return

    source = new EventSource("#{@url}?a=#{a}&b=#{b}")
    echoed_a = null
    echoed_b = null

    set_result = (result_string) =>
      if @result == "pending"
        @result = result_string
        @callback()
        source.close()

    source.addEventListener("a", (event) ->
      parsed = parseInt(event.data)
      set_result("failed") unless parsed == a
      echoed_a = parsed
    , false)

    source.addEventListener("b", (event) ->
      parsed = parseInt(event.data)
      set_result("failed") unless parsed == b
      echoed_b = parsed
    , false)

    source.addEventListener("sum", (event) ->
      parsed = parseInt(event.data)
      if echoed_a == a && echoed_b == b && parsed == a+b
        set_result("passed")
      else
        set_result("failed")
    , false)

    source.onerror = ->
      set_result("failed")

CorsTest.all_tests.push(EventSourceTest)

class EventSourceHttpsTest extends EventSourceTest
  constructor: ->
    super
    @display_name = "EventSource CORS over HTTPS"
    @url = @url.replace("http", "https").replace("4000", "4001")

CorsTest.all_tests.push(EventSourceHttpsTest)

class EventSourceSpdyTest extends EventSourceTest
  constructor: ->
    super
    @display_name = "EventSource CORS over SPDY"
    @url = "https://corstest-api.coshx.com:4002/eventsource"

  # TODO test SPDY

CorsTest.all_tests.push(EventSourceSpdyTest)
