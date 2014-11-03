module.exports = (emails) ->
  lines = emails.map (email) ->
    reason = (email.reason || "").substr(0, 40)
    "#{email.created}  #{email.email}  #{reason}"

  lines.join("\n")
