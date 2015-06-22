
js_root = `!!chrome.app.runtime ? '/public/js' : '/js'`

requirejs.config
	waitSeconds: 24
	baseUrl: js_root
	paths:
		jquery: 'vendor/jquery'
		underscore: 'vendor/underscore'
		backbone:   'vendor/backbone'
		marionette: 'vendor/backbone.marionette'

		radio:  'vendor/backbone.radio'
		moment: 'vendor/moment'

		bootstrap: 'vendor/bootstrap'
		
		jade: 'vendor/runtime'
		typeahead: 'vendor/typeahead.bundle'
		moment: 'vendor/moment'

		richmarker: 'vendor/richmarker'
		chartjs: 'vendor/Chart'

	shim:
		bootstrap:
			deps: 'jquery'
		backbone:
			deps: ['jquery', 'underscore']
			exports: 'Backbone'
		marionette:
			deps: ['backbone']
			exports: 'Marionette'
		typeahead:
			deps: ['jquery']


requirejs ['jquery', 'app'], ($, App)->

	do (()->
		sc = document.createElement 'script'
		sc.type = 'text/javascript'
		sc.src  = `!chrome.runtime.reload
			? "http://127.0.0.1:35729/livereload.js"
			: window.location.origin + "/public/livereload.js"`
		document.head.appendChild(sc)
	)

	window.App = App
	do App.start