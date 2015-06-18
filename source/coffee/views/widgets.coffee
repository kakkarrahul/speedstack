define [
	'marionette'
	'templates/views/widgets'
], (Marionette, tpl)->

	class Widgets extends Marionette.ItemView
		template: tpl
		className: 'view-widgets'

		menuData: [
			{
				title: 'Main Navigation',
				menuItems: ['Dashboard', 'Widgets', 'Layouts']
			},
			{
				title: 'Components',
				menuItems: ['Elements', 'Forms', 'Chart', 'Table', 'Maps']
			},
			{
				title: 'More',
				menuItems: ['Pages', 'Extras', 'Multilavel', 'Documentation']
			},
		],

		thatData: [
			{icon: 'fa-magic', value:'99.999', graph_text:'Games played last month', graph_line:'graph'}
			{icon: 'fa-magic', value: '99.999', graph_text:'Games played last month', graph_line:'graph'}
			{icon: 'fa-magic', value: '99.999', graph_text:'Games played last month', graph_line:'graph'}
		]

		templateHelpers: ->
			return {
				menuData: @menuData
				thatData: @thatData
			}

		initialize: ->
			#@listenToOnce this, 'render', @updateData

		updateData: ->
			@menuData[0].title = 'Now Nav'
			do @render
	
	return Widgets