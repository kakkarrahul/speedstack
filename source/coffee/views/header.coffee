define [
	'marionette'
	'radio'
	'templates/views/header'
], (Marionette, Radio, tpl)->
	
	class AppHeader extends Marionette.LayoutView
		template : tpl
		className: 'header-inner'

		ui:
			wcontrol: '.window-control'

		events:
			'click @ui.wcontrol': 'windowControl'

		windowControl: (e)->
			$control = $(e.currentTarget)
			win = chrome.app.window.current()

			switch $control.attr('data-action')
				when 'minimize' then @windowMin win
				when 'toggle'   then @windowToggle win
				when 'close'    then @windowClose win
				else 
					console.log 'Invalid Window Control'
		
		windowClose : (win)-> win.close()
		
		windowMin: (win)-> win.minimize()
		
		windowToggle: (win)->
			`win.isMaximized()
				? win.restore()
				: win.maximize()`
		


	return AppHeader