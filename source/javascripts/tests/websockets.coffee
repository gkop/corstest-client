class WebsocketsTest extends Test
  constructor: ->
    super
    @display_name = "Cross-origin Websockets"

  run: ->
    [a, b] = super

    try
      socket = new Phoenix.Socket("ws://corstest-api.coshx.com:4000/tests/websockets")
    catch
      @result = "failed"
      return

    socket.join "test_channel", "stewiecutedog", {}, (channel) =>
      channel.send("stewiecutedog:sum", {a: a, b: b})

      channel.on "return_sum", (message) =>
        if message.sum == a+b
          @result = "passed"
          @callback()

CorsTest.all_tests.push(WebsocketsTest)
