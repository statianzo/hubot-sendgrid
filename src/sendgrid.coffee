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
#
# Author:
#   statianzo

statToLabel =
  "blocked": "Blocks"
  "bounces": "Bounces"
  "clicks": "Clicks"
  "delivered": "Delivered"
  "invalid_email": "Invalids"
  "opens": "Opens"
  "repeat_bounces": "Repeat Bounces"
  "requests": "Requests"
  "spam_drop": "Spam Drops"
  "spamreports": "Spam Reports"
  "unique_clicks": "Unique Clicks"
  "unique_opens": "Unique Opens"
  "unsubscribes": "Unsubscribes"


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
        msg.send plugin.stats(json)


plugin.stats = (statDays) ->
  lines = statDays.map (day) ->
    dayLines = []
    dayLines.push "SendGrid stats for #{day.date}"
    for stat, label of statToLabel when day[stat]
      dayLines.push "#{label}: #{day[stat]}"

    dayLines.push ""

    dayLines


  # Flatten and join
  [].concat.apply([], lines).join("\n")
