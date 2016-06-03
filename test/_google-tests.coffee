Spectron_API = require '../src/Spectron-API'

describe '_google-tests',->

  spectron = null;
  target_Url  = 'https://www.google.co.uk/'

  @.timeout 4000

  before ()->
    spectron = new Spectron_API().setup()
    spectron.start()
      .then ->
        spectron.open target_Url
      .catch (err)->
        console.log 'start error: ' + err

  after ->
    spectron.stop()
      .catch (err)->
        console.log 'stop error: ' + err


  browser_API = null


  it 'no action', ()->
    console.log 'should open and close window ok'

  it 'browserWindow.getURL', (done)->
    using spectron, ->
      @.app.browserWindow.getURL().then (url)->
        console.log 'The url is: ' + url
        url.assert_Is target_Url
        done()

  it 'browserWindow.getTitle', (done)->
    using spectron, ->
      @.app.browserWindow.getTitle().then (title)->
        console.log 'The title is: ' + title
        title.assert_Is 'Google'
        done()

  it 'client.getHTML', (done)->
    using spectron, ->
      @.app.client.getHTML('*').then (html)->
        html.assert_Contains('<title>Google</title>')
        done()

  it 'client.getUrl', (done)->
    using spectron, ->
      @.app.client.getUrl().then (url)->
        url.assert_Is target_Url
        done()

