define [
	'marionette'
	'radio'
	'routers/app_router'
	'controllers/app_controller'
], (Marionette, Radio, AppRouter, AppController)->
	
	Radio.DEBUG = true
	(->
		Marionette.Application::_initChannel = ->
			@channelName = _.result(this, "channelName") or "global"
			@channel = _.result(this, "channel") or Radio.channel(@channelName)
			return
		return
	)()

	class Modularity extends Marionette.Application
		onBeforeStart: ->
			do @ajaxConfig
			do @initRouter

			#do @handleHREF
			do @setupBehaviours
		
		onStart: ->
			unless Backbone.History.started
				Backbone.history.start pushState: false, hashChange: true
				console.log 'App started'
		
		initRouter: ->
			@Router = new AppRouter
				controller: new AppController
			Radio.reply 'global', 'approuter', @Router

		setupBehaviours: ->
			window.Behaviors = {}
			Marionette.Behaviors.behaviorsLookup = -> window.Behaviors
		
		hrefWhiteList: ['sign_out', 'log_out']
		handleHREF: ->
			self = this
			
			$(document).on 'click', 'a[href^="/"]', (e)->
				href = $(e.currentTarget).attr 'href'
				passThrough = self.hrefWhiteList.indexOf(href) isnt -1

				# Allow shift+click for new tabs, etc.
				do e.preventDefault if !passThrough and !e.altKey and !e.ctrlKey and !e.metaKey and !e.shiftKey

				# Remove leading slashes and hash bangs (backward compatablility)
				url = href
						.replace  /^\//  , ''
						.replace '\#\!\/', ''

				self.Router.navigate url, trigger: true
				Radio.trigger 'global', 'approute:navigate', url

				return false	

		ajaxConfig: ->
			i = 0
			$.ajaxSetup
				crossdomain: true
				beforeSend: ->
					Radio.trigger 'global', 'loader:start'
					i++
				complete: ->
					i--
					if i<=0 then Radio.trigger 'global', 'loader:stop'


	App = new Modularity()
	return App