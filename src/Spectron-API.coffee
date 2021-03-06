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

  hide: =>
    if @.window()
      @.window().hide()
    @

  open: (url)=>
    #@.window().loadURL(url).then =>
    #  @.client().waitUntilWindowLoaded()       # this was causing an exceptions on isWindowLoading (so it might be better to add the waitUntilWindowLoaded as a separate method

    @.window().loadURL(url).then =>

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
            @.app = app

  stop: => 
    @.app.stop()

  client: => @.app?.client
  window: => @.app?.browserWindow

module.exports =   Spectron_API