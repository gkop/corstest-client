class WebsocketsTest
  constructor: ->
    @result = "pending"
    @display_name = "Cross-origin Websockets"

  run: (callback) ->
    socket = new Phoenix.Socket("ws://corstest-api.coshx.com:4000/tests/websockets")

    socket.join "test_channel", "stewiecutedog", {}, (channel) =>
      a = Math.floor((Math.random() * 100000) + 1)
      b = Math.floor((Math.random() * 100000) + 1)
      channel.send("stewiecutedog:sum", {a: a, b: b})

      channel.on "return_sum", (message) =>
        if message.sum == a+b
          @result = "passed"
          callback(@) if callback

CorsTest.all_tests.push(WebsocketsTest)
