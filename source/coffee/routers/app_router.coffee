define [
	'marionette'
	'radio'
], (Marionette, Radio)->

	class AppRouter extends Marionette.AppRouter
		
		appRoutes:
			'(/)' : 'home'
			
			'login(/)' : 'login'
			'logout(/)': 'logout'
			'yo(/)': 'yopage'

			'widgets(/)': 'widgets'
			'charts(/)': 'charts'
			'songs(/)': 'songs'
			
		initialize: (options)->
			console.log 'AppRouter::OK'

	return AppRouter