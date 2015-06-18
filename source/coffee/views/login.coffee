define [
	'marionette'
	'radio'
	'templates/views/login'
], (Marionette, Radio, tpl)->

	class LoginView extends Marionette.ItemView
		template: tpl
		className: 'view-login'
		initialize: ->
			console.log 'Login Loaded a'
	return LoginView
