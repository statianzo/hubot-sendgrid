Error.stackTraceLimit = 1

samples = require("./samples")
cmd = require("../src/stats")

res = stats = lines = null
any = (f, xs) ->
  for x in xs when f(x)
    return true
  false

anyMatch = (m, xs) -> any ((x) -> x.match(m)), xs

module.exports =
  setUp: (done) ->
    stats = samples.stats()
    res = cmd stats
    lines = res.split("\n")
    done()

  "empty string when no stats": (test) ->
    res = cmd []
    test.equal("", res)
    test.done()

  "Includes banner for date": (test) ->
    test.ok(lines[0].match stats[0].date, "Missing banner")
    test.done()

  "Includes populated stats": (test) ->
    labels = [
      "Delivered", "Unsubscribes", "Invalids", "Bounces",
      "Clicks", "Opens", "Unique Opens", "Repeat Bounces"
    ]

    for l in labels
      test.ok(anyMatch(l, lines), "Missing label #{l}")
    test.done()

  "Skips zeroed stats": (test) ->
    test.ok(!anyMatch("Blocks", lines), "Included zeroed label Blocks")
    test.done()
