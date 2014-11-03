Error.stackTraceLimit = 1

samples = require("./samples")
cmd = require("../src/list")

res = bounces = lines = null
any = (f, xs) ->
  for x in xs when f(x)
    return true
  false

anyMatch = (m, xs) -> any ((x) -> x.match(m)), xs

module.exports =
  setUp: (done) ->
    bounces = samples.bounces()
    res = cmd bounces
    lines = res.split("\n")
    done()

  "empty string when no emails": (test) ->
    res = cmd []
    test.equal("", res)
    test.done()

  "one line per email": (test) ->
    test.equal(bounces.length, lines.length)
    test.done()

  "shows email, date, and reason on each line": (test) ->
    for bounce in bounces
      test.ok anyMatch(bounce.email, lines), "#{bounce.email} missing"
      test.ok anyMatch(bounce.created, lines), "#{bounce.created} missing"
      test.ok anyMatch(bounce.reason.substr(0,20), lines), "#{bounce.reason.substr(0,40)} missing"
    test.done()
