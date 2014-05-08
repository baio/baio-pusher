android = require "./android"
ios = require "./ios"
async = require "async"

exports.setConfig = (config)  ->
  ios.setConfig config.ios

# @opts - object
# @opts.platform { android | ios }
# @opts.key { device regitration key }
exports.push = (opts, title, msg, done) ->

  androidPushes = opts.filter((f) -> f.platform == "android").map (m) -> m.key
  iosPushes = opts.filter((f) -> f.platform == "ios").map (m) -> m.key

  async.parallel [
    (ck) -> android.push androidPushes, title, msg, ck
    (ck) -> ios.push iosPushes, title, msg, ck
  ], done


