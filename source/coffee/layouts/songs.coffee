define [
	'marionette'
	'radio'
	'templates/layouts/songs'
	'components/songslist/view'
	'components/nowplaying/view'
	'components/controlbar/view'
], (Marionette, Radio, tpl, SongsListView, NowPlayingView, ControlBarView)->

	player = Radio.channel 'player'
	
	class SongsLayout extends Marionette.LayoutView
		template: tpl
		className: 'view-songs'

		model: new Backbone.Model()

		regions:
			NowPlaying: '.region-now-playing'
			SongsList:  '.region-songs-list'
			ControlBar: '.region-control-bar'

		onRender: ->
			@NowPlaying.show new NowPlayingView()
			@SongsList.show new SongsListView()
			@ControlBar.show new ControlBarView()

		

	return SongsLayout