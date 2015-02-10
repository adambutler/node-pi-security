fs = require("fs")
path = require("path")
Player = require("player")
resemble = require("resemble").resemble
_ = require("lodash")

exec = require("exec")

imagesnap = require("imagesnap")
fs = require("fs")

player = new Player('./alert.mp3')
playing = false

player.on "playing", (item) ->
  playing = true

player.on "playend", (item) ->
  playing = false

class Camera
  path: "./data"

  constructor: ->
    @cleanup()

  cleanup: ->
    fs.readdir @path, (err, list) =>
      list = list.filter((file) -> path.extname(file) is ".jpg")
      for item in list
        fs.unlink("#{@path}/#{item}")

  alert: ->
    player.play() unless playing

  freeSpace: (list) ->
    if list.length > 50
      fs.unlink("#{@path}/#{list[0]}")

  diff: ->
    fs.readdir @path, (err, list) =>
      list = list.filter((file) -> path.extname(file) is ".jpg")

      @freeSpace(list)

      list = list.reverse()

      console.log list

      fs.readFile "#{@path}/#{list[0]}", (err, current) =>
        if list[1]?
          fs.readFile "#{@path}/#{list[1]}", (err, last) =>
            resemble(current).compareTo(last).onComplete (data) =>
              console.log data
              @alert() if data.misMatchPercentage > 3

  capture: ->
    exec "imagesnap -w 1 -o '#{@path}/capture-#{@timestamp()}.jpg'", =>
      @diff()

  timestamp: ->
    now = new Date()
    year = "" + now.getFullYear()
    month = "" + (now.getMonth() + 1)
    month = "0" + month  if month.length is 1
    day = "" + now.getDate()
    day = "0" + day  if day.length is 1
    hour = "" + now.getHours()
    hour = "0" + hour  if hour.length is 1
    minute = "" + now.getMinutes()
    minute = "0" + minute  if minute.length is 1
    second = "" + now.getSeconds()
    second = "0" + second  if second.length is 1
    year + "-" + month + "-" + day + "-" + hour + ":" + minute + ":" + second

camera = new Camera()

setInterval ->
  camera.capture()
, 2000

