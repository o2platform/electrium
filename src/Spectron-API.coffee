require 'fluentnode'

spectron = require 'spectron'

class Spectron_API
  
  constructor: (options)->
    @.options     = options || {}
    @.Application = spectron.Application
    @.app         = null
    @.root_Path   = wallaby?.localProjectDir || __dirname.path_Combine '../'        
    
  is_Running: =>
    @.app?.isRunning() || false

  open: (url)=>
    @.window().loadURL(url)
    @.client().waitUntilWindowLoaded()      

  setup: =>
    @.options.path  = @.root_Path.path_Combine 'node_modules/.bin/electron'
    @.options.args ?= [ __dirname.path_Combine '../electron-apps/node-about-blank' ]
    @

  show: =>
    if @.window()
      @.window().showInactive()
    @
    
  start: =>
    new @.Application(@.options)
          .start()
          .then (app)=>
            console.log 'here after start'
            @.app = app

  stop: => 
    @.app.stop()

  client: => @.app?.client
  window: => @.app?.browserWindow

module.exports =   Spectron_API