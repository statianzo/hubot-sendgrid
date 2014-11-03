path = require 'path'

module.exports = (robot, scripts) ->
  scriptPath = path.resolve(__dirname, 'src')
  robot.loadFile(scriptPath, 'sendgrid.coffee')
