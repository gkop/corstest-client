class EventSourceTest
  constructor: ->
    @result = "pending"
    @display_name = "EventSource CORS"

  run: (callback) ->
    if window.location.protocol.match(/https/)
      @result = "not run"
      return

    a = Math.floor((Math.random() * 100000) + 1)
    b = Math.floor((Math.random() * 100000) + 1)
    source = new EventSource("http://corstest-api.coshx.com:4000/tests/eventsource?a=#{a}&b=#{b}")
    echoed_a = null
    echoed_b = null

    set_result = (result_string) =>
      if @result == "pending"
        @result = result_string
        callback(@) if callback
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
