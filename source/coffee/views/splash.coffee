define [
	'marionette'
	'radio'
	'templates/views/splash'
], (Marionette, Radio, tpl)->


	class SplashPage extends Marionette.ItemView
		template: tpl
		className: 'view-splashpage'

		model: new Backbone.Model
			navData: [
				{url: 'login', title: 'Login'}
				{url: 'songs', title: 'Songs'}
				{url: 'charts', title: 'Charts'}
			]

	return SplashPage
