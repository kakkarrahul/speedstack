define [
	'marionette'
	'radio'
	'./tpl-view'
	'css!./style'
], (Marionette, Radio, tpl)->
	
	player = Radio.channel 'player'

	model = new Backbone.Model
		title: 'Select a song'
		albumartist: 'No Artist'
		year: '-'


	class NowPlayingView extends Marionette.ItemView
		template: tpl
		className: 'view-now-playing'
		model: model
		query_url: 'https://itunes.apple.com/search?term=__query__&limit=5'

		initialize: ->
			@listenTo @model, 'change', @render
			@listenTo player, 'play:song', @update
			@listenTo player, 'play:song', @fetchData
			@listenTo player, 'data:fetched', @update


		toQuery: ->
			str = "#{@model.get('title')}+#{@model.get('albumartist')}"
			return str.replace(/ /g, '+')

		logError: (err)->
			console.error 'NowPlaying: Fetch failed.', err
		
		fetchData: ->
			query = do @toQuery
			url = @query_url.replace '__query__', query
			
			Promise
				.resolve $.getJSON(url)
					.catch @logError
				.then (resp)=>
					@model.set resp.results[0]

		update: (newsong)->
			@model.set newsong.toJSON()

		fetchImage: (url)-> return new Promise (resolve, reject)->
			xhr = new XMLHttpRequest()
			xhr.open 'GET', url, true
			xhr.responseType = 'blob'
			xhr.onload = (e)->
				blob_url = window.URL.createObjectURL(this.response)
				resolve(blob_url)
			xhr.onerror = (err)-> reject(err)
			do xhr.send

		onRender: ->
			self = this
			imgs = @$el.find 'img'
			imgs.each ->
				url = $(this).attr 'data-src'
				self
					.fetchImage url
					.then (bloburl)=> $(this).attr 'src', bloburl



	return NowPlayingView