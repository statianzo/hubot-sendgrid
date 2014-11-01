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
          cb(null, json)

  robot.respond /sendgrid stats (\d{4}-\d{2}-\d{2})/i, (msg) ->


plugin.stats = (statDays) ->
  ""
