define [
	'marionette'
	'radio'
], (Marionette, Radio)->

	class AutoLayout extends Marionette.LayoutView
		
		rMap = {}
		counter = 0
		
		constructor: ->
			@listenTo this, 'urls:loaded'  , @attachViews
			@listenTo this, 'before:render', @attachViews
			do @fetchViews
			super

		attachViews: =>
			_.each rMap , (view, rName)=>
				return if _.isString(view)
				r = @getRegion rName
				r.show new view()
		
		fetchViews: =>
			counter = 0
			rMap = _.result this, 'regionViews'

			_.each rMap, (url, rName)=>
				counter++
				Radio.trigger 'global', 'loader:start'
				requirejs [url], (view)=>
					rMap[rName] = view
					counter--
					if counter<=0
						Radio.trigger 'global', 'loader:stop'
						@trigger 'urls:loaded'

	return AutoLayout