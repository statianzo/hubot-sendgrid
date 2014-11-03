# Description:
#   Display stats from SendGrid
#
# Dependencies:
#
# Configuration:
#   HUBOT_SENDGRID_USER
#   HUBOT_SENDGRID_KEY
#
# Commands:
#   hubot sendgrid stats [YYYY-MM-DD] - Email stats for date (default today)
#   hubot sendgrid <type> [YYYY-MM-DD] [limit] - bounces, blocks, invalids, spam reports, unsubscribes
#
# Author:
#   statianzo

stats = require('./stats')
list = require('./list')

today = ->
  date = new Date
  yyyy = date.getFullYear().toString()
  mm = (date.getMonth()+1).toString()
  dd  = date.getDate().toString()
  "#{yyyy}-#{if mm[1] then mm else "0"+mm[0]}-#{if dd[1] then dd else "0"+dd[0]}"

module.exports = plugin = (robot) ->
  apiUser = process.env.HUBOT_SENDGRID_USER
  apiKey = process.env.HUBOT_SENDGRID_KEY
  apiBaseUrl = "https://sendgrid.com/api/"
  request = (path, params, cb) ->
    robot.http(apiBaseUrl + path)
      .query('api_key', apiKey)
      .query('api_user', apiUser)
      .query(params)
      .post() (err, res, body) ->
        if err
          cb(err)
        else
          json = JSON.parse(body)
          if json.error
            cb(new Error(body))
          else
            cb(null, json)

  robot.respond /sendgrid stats( (\d{4}-\d{2}-\d{2}))?/i, (msg) ->
    params = {}
    date = msg.match[2]
    if date
      params.start_date = date
      params.end_date = date

    request 'stats.get.json', params, (err, json) ->
      if (err)
        msg.send "Failed: #{err.message}"
      else
        msg.send stats(json)

  robot.respond /sendgrid (blocks|bounces|invalids|spam reports|unsubscribes)( (\d{4}-\d{2}-\d{2}))?( (\d+))?/i, (msg) ->
    params = {date: 1}
    op = msg.match[1]
    date = msg.match[3] || today()
    params.limit = parseInt(msg.match[5]) || 10
    params.start_date = date
    params.end_date = date

    path = switch op
      when "blocks" then "blocks.get.json"
      when "bounces" then "bounces.get.json"
      when "invalids" then "invalidemails.get.json"
      when "spam reports" then "spamreports.get.json"
      when "unsubscribes" then "unsubscribes.get.json"

    return unless path

    request path, params, (err, json) ->
      if (err)
        msg.send "Failed: #{err.message}"
      else
        msg.send list(json)
