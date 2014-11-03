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

module.exports = (statDays) ->
  lines = statDays.map (day) ->
    dayLines = []
    dayLines.push "SendGrid stats for #{day.date}"
    for stat, label of statToLabel when day[stat]
      dayLines.push "#{label}: #{day[stat]}"

    dayLines.push ""

    dayLines

  # Flatten and join
  [].concat.apply([], lines).join("\n")
