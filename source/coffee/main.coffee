js_root = '/js'

((chrome)->
	if chrome and chrome.app and chrome.app.runtime
		js_root = '/public/js'
)(window.chrome)

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


	window.fetch_blob = (url, ret_as)-> return new Promise (resolve, reject)->
		xhr = new XMLHttpRequest()
		xhr.open 'GET', url, true
		xhr.responseType = 'blob'
		xhr.onload = (e)->
			blob_url = window.URL.createObjectURL(this.response)
			resolve blob_url			
		xhr.onerror = (err)-> reject(err)
		do xhr.send

	window.App = App
	do App.start