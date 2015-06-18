define [
	'marionette'
	'radio'
	'collections/songs'
	'./view-item'
	'./tpl-view'
	'lib_data'
	'css!./style'
], (Marionette, Radio, Songs, SongItem, tpl, data)->

	player = Radio.channel 'player'

	music_server = 'http://localhost:4300'
	songs_arr = data.map (k)->
		filename = k.path.substr(k.path.lastIndexOf('/')+1)
		k.path = music_server + '/' + encodeURI(filename)
		return k
	

	SongsData = new Songs(songs_arr)
	
	class SongsListView extends Marionette.CompositeView
		template: tpl
		className: 'view-songs-list'
		collection: SongsData
		childView: SongItem
		childViewContainer: '.list-songs'
		
		initialize: ->
			@listenTo player, 'play:song', @selectSong

		selectSong: (model)->
			selected = @collection.findWhere is_selected: true

	return SongsListView