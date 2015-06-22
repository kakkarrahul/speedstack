define [
	'marionette'
	'radio'
	'./tpl-view-item'
], (Marionette, Radio, itemTpl)->

	player = Radio.channel 'player'

	class SongItem extends Marionette.ItemView
		template: itemTpl
		tagName: 'li'
		className: 'song-item'
		ui:
			inner: '.song-inner'

		events:
			'click @ui.inner': 'play'
		initialize: ->
			@listenTo @model, 'change', @render
		
		play: (e)->
			console.log 'Playing Song: ', @model
			
			player.trigger 'play:song', @model
			player.trigger 'ui:select:song', @$el

	return SongItem