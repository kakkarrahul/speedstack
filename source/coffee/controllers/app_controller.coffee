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
		
		login:  -> @RM.load Content: 'views/login'
		logout: -> @RM.load Content: 'views/logout'

		home: ->
			@RM.load
				Header : 'views/header'
				Content: 'views/splash'

		yopage: -> 
			@RM.load
				Header: 'views/header'
				Content: 'views/yoview'
		widgets: ->
			@RM.load 
				Header:  'views/header'
				Content: 'views/widgets'

		charts: ->
			@RM.load 
				Header: 'views/header'
				Content: 'views/charts'
			
		songs: ->
			@RM.load 
				Header:  'views/header'
				Content: 'layouts/songs'	
			
	return AppController