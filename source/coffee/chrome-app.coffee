
windowOptions =
	bounds:
		width : 1024
		height: 600
		left  : (screen.width/2 - 512)
		top   : (screen.height/2 - 300)
	frame: "none"


chrome.app.runtime.onLaunched.addListener (options)->
	chrome.app.window.create 'public/index.html', windowOptions, (win)->
		console.log 'ChromeApp Loaded'

		# After Initialization, maximize the window
		# return win.maximize()