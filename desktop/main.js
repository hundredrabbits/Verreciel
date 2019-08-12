const {app, BrowserWindow, webFrame, Menu} = require('electron')
const path = require('path')
const url = require('url')
const shell = require('electron').shell;

let is_shown = true;

app.inspect = function()
{
  app.win.toggleDevTools();
}

app.toggle_fullscreen = function()
{
  app.win.setFullScreen(app.win.isFullScreen() ? false : true);
}

app.toggle_visible = function()
{
  if(is_shown){ app.win.hide(); } else{ app.win.show(); }
}

app.inject_menu = function(m)
{
  Menu.setApplicationMenu(Menu.buildFromTemplate(m));
}

app.win = null;

app.on('ready', () => 
{
  app.win = new BrowserWindow({
    width: 780,
    height: 392,
    minWidth: 380,
    minHeight: 360,
    backgroundColor: '#000',
    icon: path.join(__dirname, { darwin: 'icon.icns', linux: 'icon.png', win32: 'icon.ico' }[process.platform] || 'icon.ico'),
    resizable: true,
    frame: process.platform !== 'darwin',
    skipTaskbar: process.platform === 'darwin',
    autoHideMenuBar: process.platform === 'darwin',
    webPreferences: { zoomFactor: 1.0, nodeIntegration: true, backgroundThrottling: false }
  })
  
  app.win.loadURL(`file://${__dirname}/index.html`)
  // app.win.toggleDevTools();
  
  app.win.on('closed', () => {
    win = null
    app.quit()
  })

  app.win.on('hide',function() {
    is_shown = false;
  })

  app.win.on('show',function() {
    is_shown = true;
  })
})

app.on('window-all-closed', () => 
{
  app.quit()
})

app.on('activate', () => {
  if (app.win === null) {
    createWindow()
  }
})