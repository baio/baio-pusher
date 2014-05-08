apn = require "apn"

config  = null

exports.setConfig = (_config) ->
  config = _config

exports.push = (ids, title, msg, done) ->

  options = {}

  if config
    options.cert = config.cert
    options.key = config.key

  apnConnection = new apn.Connection(options)

  for id in ids
    myDevice = new apn.Device(id)

    note = new apn.Notification()

    note.expiry = Math.floor(Date.now() / 1000) + 3600
    #note.badge = 1;
    note.sound = "ping.aiff"
    note.alert = title
    note.payload = 'message': msg

    apnConnection.pushNotification(note, myDevice)

  done()