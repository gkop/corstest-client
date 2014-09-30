class WebsocketsTlsTest extends Test
  constructor: ->
    super
    @display_name = "Cross-origin Websockets over TLS"

  run: ->
    [a, b] = super

    socket = new Phoenix.Socket("wss://corstest-api.coshx.com:4001/tests/websockets")

    socket.join "test_channel", "stewiecutedog", {}, (channel) =>
      channel.send("stewiecutedog:sum", {a: a, b: b})

      channel.on "return_sum", (message) =>
        if message.sum == a+b
          @result = "passed"
          @callback()

CorsTest.all_tests.push(WebsocketsTlsTest)
