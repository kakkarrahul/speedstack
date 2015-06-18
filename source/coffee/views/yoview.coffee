define [
	'marionette'
	'templates/views/social'
], (Marionette, tpl)->

	class YoView extends Marionette.ItemView
		template: tpl
		onRender: ->
			console.log 'Showing View'

	return YoView