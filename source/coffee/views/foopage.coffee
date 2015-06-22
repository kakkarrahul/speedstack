define [
	'marionette'
	'templates/views/foopage'
], (Marionette, tpl)->
	
	class FooPageView extends Marionette.ItemView
		template: tpl
		className: 'view-foopage'
	return FooPageView