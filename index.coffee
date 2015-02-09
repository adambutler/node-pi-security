fs = require("fs")
resemble = require("resemble").resemble

files = []

fs.readFile './fixtures/a.jpg', (err, data) ->
  throw err if err
  files.push data
  fs.readFile './fixtures/b.jpg', (err, data) ->
    throw err if err
    files.push data
    fs.readFile './fixtures/c.jpg', (err, data) ->
      throw err if err
      files.push data

      resemble(files[0]).compareTo(files[1]).onComplete (data) ->
        console.log(data)

        resemble(files[1]).compareTo(files[2]).onComplete (data) ->
          console.log(data)


