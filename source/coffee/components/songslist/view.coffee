define [
	'marionette'
	'radio'
	'collections/songs'
	'./view-item'
	'./tpl-view'
	'css!./style'
], (Marionette, Radio, Songs, SongItem, tpl)->

	player = Radio.channel 'player'
	
	class SongsListView extends Marionette.CompositeView
		template: tpl
		className: 'view-songs-list'
		
		collection: Songs
		
		childView: SongItem
		childViewContainer: '.list-songs'
		
		initialize: ->
			@listenTo player, 'ui:select:song', @selectSong
			
			do @collection.fetch
		
		selectSong: ($selected)->
			@$el
				.find '.list-songs'
				.children()
				.each -> $(this).removeClass('active') unless $(this).is($selected)
			$selected.addClass 'active'

	return SongsListView