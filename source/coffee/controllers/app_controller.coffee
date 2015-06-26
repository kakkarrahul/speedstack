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
			@RM.load
				Background: 'components/background/view'
				Header: 'views/header'
			console.log 'AppController::OK'
		
		onBeforeDestroy: -> do @RM.destroy
		
		
		# Controllers
		
		login:  ->  @RM.load Content: 'views/login'
		logout: ->  @RM.load Content: 'views/logout'

		home: -> @RM.load Content: 'views/splash'			
		songs: -> @RM.load  Content: 'layouts/songs'
		charts: -> @RM.load Content: 'views/charts'

		yopage: -> @RM.load Content: 'views/yopage'
		
		foopage: -> @RM.load Content: 'views/foopage'	
			
	return AppController