class EventSourceHttpsTest extends Test
  constructor: ->
    super
    @display_name = "EventSource CORS over HTTPS"

  run: ->
    [a, b] = super

    source = new EventSource("https://corstest-api.coshx.com:4001/tests/eventsource?a=#{a}&b=#{b}")
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

CorsTest.all_tests.push(EventSourceHttpsTest)
