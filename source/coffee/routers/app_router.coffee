define [
	'marionette'
	'radio'
], (Marionette, Radio)->

	approuter = Radio.channel 'approuter'
	class AppRouter extends Marionette.AppRouter
		
		appRoutes:
			'(/)' : 'home'
			
			'login(/)' : 'login'
			'logout(/)': 'logout'
			
			'charts(/)': 'charts'
			'songs(/)': 'songs'
			
		initialize: (options)->
			@listenTo approuter, 'go:back', @goBack
			console.log 'AppRouter::OK'

		goBack: ->
			console.log 'Going back: '
			do @back

	return AppRouter