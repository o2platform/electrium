Spectron_API = require '../../src/Spectron-API'

Number::wait = (callback)->
  new Promise (resolve)=>
    @.invoke_After ->
      resolve()
      callback() if callback

describe 'Dev Spectron API tests',->

  @.timeout 8000

  spectron = null;

  before ->
    spectron = new Spectron_API().setup()
    spectron.start()


  after ->
    spectron.stop()

  it 'open (BBC news)', ()->
    url = 'http://news.bbc.co.uk'
    using spectron, ->
      @.open(url).then =>
        @.window().getURL().then (url)=>
          url.assert_Is url

  it 'open Google', ->
    #spectron.setup()
    using spectron, ->
      #@.start()
        #.then =>
          @.window().showInactive()
          @.window().loadURL('http://www.google.com')
          @.client().waitUntilWindowLoaded().then =>
            @.client().getTitle().then (title)=>
              title.assert_Is ''
              @.client().getHTML('*').then (html)=>
                html[0].assert_Contains 'Google'
