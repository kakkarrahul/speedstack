define [
	'marionette'
	'radio'
	'./tpl-view'
	'css!./style'
], (Marionette, Radio, tpl)->
	
	player = Radio.channel 'player'

	Model = new Backbone.Model

	class ControlBarView extends Marionette.ItemView
		template: tpl
		className: 'view-control-bar'
		model: Model
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
			window.aa = this
			@listenTo player, 'play:song', @playSong

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

	return ControlBarView