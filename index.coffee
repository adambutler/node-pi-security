fs = require("fs")
Player = require("player")

resemble = require("resemble").resemble

files = []

fs.readFile process.argv[2], (err, data) ->
  throw err if err
  files.push data
  fs.readFile process.argv[3], (err, data) ->
    throw err if err
    files.push data

    resemble(files[0]).compareTo(files[1]).onComplete (data) ->
      console.log(data)
      if data.misMatchPercentage > 1
        new Player('./alert.mp3').play()


