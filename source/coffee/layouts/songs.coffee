define [
	'marionette'
	'radio'
	'templates/layouts/songs'
	'components/songslist/view'
	'components/nowplaying/view'
], (Marionette, Radio, tpl, SongsListView, NowPlayingView)->

	player = Radio.channel 'player'
	
	class SongsLayout extends Marionette.LayoutView
		template: tpl
		className: 'view-songs'

		model: new Backbone.Model()

		regions:
			NowPlaying: '.region-now-playing'
			SongsList:  '.region-songs-list'

		ui:
			play: '.player-controls .to-play'
			next: '.player-controls .to-next'
			prev: '.player-controls .to-prev'

		events:
			'click @ui.play': 'togglePlay'
			'click @ui.next': 'nextSong'
			'click @ui.prev': 'prevSong'

		player: document.createElement('audio')

		initialize: ->
			@listenTo @model, 'change', @render
			@listenTo player, 'play:song', @playSong

		onRender: ->
			@NowPlaying.show new NowPlayingView()
			@SongsList.show new SongsListView()

		playSong: (model)->
			@model.set
				title: model.get 'title'
				album: model.get 'albumartist'
				year: model.get 'year'
			@player.src = model.get('path');
			@player.play()

			@ui.play.find('i').get(0).className = 'fa fa-pause'

		togglePlay: ->
			@ui.play
				.find('i')
				.get(0)
				.className = `this.player.paused ? 'fa fa-pause' : 'fa fa-play'`;
			return `this.player.paused ? this.player.play(): this.player.pause()`
		
		nextSong: ->
			current = @collection.findWhere is_selected: true
			unless current
				console.log 'No song selected'
				return

			current.set 'is_selected', false
			ci = @collection.indexOf current
			next = `this.collection.length === ci + 1 ? 0 : ci`
			@collection.at(next).set is_selected: true

	return SongsLayout