define [
	'helpers/autolayout'
], (AutoLayout)->

	class RegionManager extends AutoLayout
		regions:
			Header : '#app-header'
			Sidebar: '#app-sidebar'
			Content: '#app-content'
			Overlay: '#app-overlay'
			Background: '#app-background'

		load: (rMap)->
			@regionViews = _.extend {}, rMap
			do @fetchViews

	class AppController extends Marionette.Controller
		
		initialize: ->
			@RM = new RegionManager({el: 'body'})
			console.log 'AppController::OK'
		
		onBeforeDestroy: -> do @RM.destroy
		
		
		# Controllers
		
		login:  -> 
			@RM.load 
				Header : 'views/header'
				Content: 'views/login'
		logout: -> 
			@RM.load 
				Header : 'views/header'
				Content: 'views/logout'

		home: ->
			@RM.load
				Header : 'views/header'
				Content: 'views/splash'			
		songs: ->
			@RM.load 
				Header:  'views/header'
				Content: 'layouts/songs'
		charts: ->
			@RM.load 
				Header:  'views/header'
				Content: 'views/charts'
			
	return AppController