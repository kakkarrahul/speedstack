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

		update: (song)->
			@model.clear().set song.toJSON()

			song
				.fetchData()
				.then => 
					@model.set song.toJSON()
					player.trigger 'data:fetched', @model

		onRender: ->
			self = this
			targets = @$el.find '.blob-image'
			targets.each ->
				url = $(this).attr 'data-src'
				if url is ''
					return
				fetch_blob(url).then (bloburl)=>
					if $(this).get(0).tagName is "IMG"
						$(this).attr 'src', bloburl
					else
						$(this).css 'background-image', "url('" + bloburl + "')"



	return NowPlayingView