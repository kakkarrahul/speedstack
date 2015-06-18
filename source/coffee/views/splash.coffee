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
				{url: ''  , title: 'Home'}
				{url: 'yo', title: 'Yo Page'}
				{url: 'widgets', title: 'Widgets'}
				{url: 'songs', title: 'Songs'}
				{url: 'charts', title: 'Charts'}
			]

	return SplashPage
