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
    using spectron, ->
      @.window().showInactive()
      @.window().loadURL('https://www.google.co.uk').then =>
        @.client().getHTML('*').then (html)=>
          html[0].assert_Contains 'Google'
          @.client().getTitle().then (title)=>
            title.assert_Is 'Google'