"use strict"
gcm = require("node-gcm")

exports.push = (ids, title, msg, done) ->

  if !ids.length
    done()
    return

  message = new gcm.Message()

  #API Server Key
  sender = new gcm.Sender("AIzaSyBCgvcnt_hZMv1ht-LW53EoWKHV8FUrlv4")

  # Value the payload data to send...
  message.addData "message", msg
  message.addData "title", title
  message.addData "msgcnt", "1" # Shows up in the notification in the status bar
  message.addData "soundname", "beep.wav" #Sound to play upon notification receipt - put in the www folder in app
  #message.collapseKey = 'demo';
  #message.delayWhileIdle = true; //Default is false
  message.timeToLive = 3000 # Duration in seconds to hold in GCM and retry before timing out. Default 4 weeks (2,419,200 seconds) if not specified.

  # At least one reg id required
  registrationIds = []
  for id in ids
    registrationIds.push id

  ###
  Parameters: message-literal, registrationIds-array, No. of retries, callback-function
  ###
  sender.send message, registrationIds, 4, done

