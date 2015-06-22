define [
	'marionette'
	'radio'
	'./tpl-view'
	'css!./style'
], (Marionette, Radio, tpl)->
	
	player = Radio.channel 'player'

	model = new Backbone.Model
		title: 'Select a song'
		album_artist: 'No Artist'
		year: '-'


	class NowPlayingView extends Marionette.ItemView
		template: tpl
		className: 'view-now-playing'
		model: model

		initialize: ->
			@listenTo @model, 'change', @render
			@listenTo player, 'play:song', @update
			@listenTo player, 'data:fetched', @update

		update: (song)->
			song
				.fetchData()
				.then =>
					@model.clear().set song.toJSON()

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
			targets = @$el.find '.blob-image'
			targets.each ->
				url = $(this).attr 'data-src'
				if url is ''
					return
				self.fetchImage(url).then (bloburl)=>
					if $(this).get(0).tagName is "IMG"
						$(this).attr 'src', bloburl
					else
						$(this).css 'background-image', "url('" + bloburl + "')"



	return NowPlayingView