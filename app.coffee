connect = require 'connect'
connect_assets = require 'connect-assets'
express = require 'express'
jade = require 'jade'

app = express()

app.configure ->
  app.set 'view engine', 'jade'
  app.set 'views', __dirname + '/views'

  app.use connect_assets()
  app.use connect.bodyParser()
  app.use connect.static(__dirname + '/public')
  app.use app.router

app.configure 'development', ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack     : true

app.configure 'production', ->
  app.use express.errorHandler()

app.get '/', (req, res) ->
  res.render 'map', {}

server = app.listen(process.env.PORT || 8080)
console.log 'Server started on port %s', server.address().port
