define [
	'marionette'
	'radio'
	'./tpl-view-item'
], (Marionette, Radio, itemTpl)->

	class SongItem extends Marionette.ItemView
		template: itemTpl
		tagName: 'li'
		className: 'song-item'
		ui:
			inner: '.song-inner'
		events:
			'click @ui.inner': 'play'

		initialize: ->
			@listenTo @model, 'change:is_selected', @activate

		play: (e)->
			@model.set 'selected', true
			Radio.trigger 'player', 'play:song', @model

	return SongItem