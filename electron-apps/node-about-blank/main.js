var app = require('electron').app
var BrowserWindow = require('electron').BrowserWindow

var mainWindow = null

app.on('ready', function () {
    mainWindow = new BrowserWindow({
        show      : false,
        //center    : true,
        //x         : 100,
        x         : 1200,
        y         : -1000,
        width     : 500,
        height    : 400,
        webPreferences: {
            nodeIntegration: true }
    })
    mainWindow.loadURL('about:blank')

    mainWindow.on('closed', function () { mainWindow = null })
})
