Spectron_API = require '../../src/Spectron-API'
path = require 'path'

wait = ()->
  new Promise (resolve)=>
    1000.wait ->
      resolve()

Application = require('spectron').Application

getElectronPath =  ()->

  path.join(__dirname, '..','..', 'node_modules', '.bin', 'electron')



startApplication = ()->
  options = {}
  console.log  'here'
  options.path = getElectronPath()
  app = new Application(options)
  return app.start().then ()->
      console.log 'after created -----------------'
      console.log app
      app

Number::wait = (callback)->
  new Promise (resolve)=>
    @.invoke_After ->
      resolve()
      callback() if callback

describe.only 'Dev Spectron API tests',->

  @.timeout 8000

  spectron = null;

  before ->
    spectron = new Spectron_API().setup()
    spectron.start()
    #.then ->
    #  console.log 'here after start 23'

  after ->
    #wait().then ->
    spectron.stop()

  it 'test 1 (BBC news)', ()->
    #startApplication()

  xit 'open (BBC news)', (done)->
    spectron = new Spectron_API().setup()
    console.log  path.join(__dirname, '..','..', 'node_modules', '.bin', 'electron')
    console.log spectron.options.path

    #console.log  spectron.options
    #spectron.options.args[0] = '/Users/diniscruz/GitHub_REPOS/electrium/electron-apps/web-view'
    #spectron.options.args = ['/Users/diniscruz/GitHub_REPOS/spectron/test/fixtures/example']
    spectron.options.args = ['/Users/diniscruz/GitHub_REPOS/electrium/electron-apps/about-blank']

    new Application(spectron.options).start().then (app)->
        console.log app.browserWindow
        done()

    #new Application(path : spectron.options.path).start()
    return
    return app_2.then (app)->
      #app.browserWindow.loadURL('about:blank')
      app.browserWindow.loadURL('http://news.bbc.co.uk')
      console.log 'after created '
      app.client.waitUntilWindowLoaded().then ->
        console.log 'after loaded '
        console.log app.browserWindow is undefined
        512.wait ->
          app.stop().then ->
            console.log 'after stopped'
            done()

    return

    return spectron.setup().start().then ->
      console.log spectron.app

    #console.log spectron.app.client
#    console.log spectron.app.client.then ->
#      console.log 'here'
#      console.log this
#      console.log  spectron.app.client
#      done()
    done()
    return

  it 'open (BBC news)', ()->
    url = 'http://news.bbc.co.uk'
    using spectron.show(), ->
      @.open(url).then =>
        @.window().getURL().then (url)=>
            url.assert_Is url

  xit 'start window manually', ->
    spectron.setup()
    using spectron, ->
      @.start()
        .then =>
          @.window().showInactive()
          @.window().loadURL('http://www.google.com')
          @.client().waitUntilWindowLoaded().then =>
            @.client().getTitle().then (title)=>
              title.assert_Is ''
              @.client().getHTML('*').then (html)=>
                html[0].assert_Contains 'Google'
