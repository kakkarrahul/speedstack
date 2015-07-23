define [
	'marionette'
	'templates/views/theme'
], (Marionette, tpl)->
	
		
	ListModel = new Backbone.Model
		list_items: [
			{url: '#', title: 'Service'}
			{url: '#', title: 'About'}
			{url: '#', title: 'Work'}
			{url: '#', title: 'Blog'}
			{url: '#', title: 'Contact'}
		]


	class ThemeView extends Marionette.ItemView
		template: tpl
		model: ListModel

	return ThemeView