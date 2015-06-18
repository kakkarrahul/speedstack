define [
	'marionette'
	'templates/views/charts'
	'chartjs'
], (Marionette, tpl)->


	class ChartsView extends Marionette.ItemView
		template: tpl

		ui:
			barchart: '#barChart'
			radarchart: '#radarChart'

		bardata: 
			labels: ["January", "February", "March", "April", "May", "June", "July"],
			datasets: [
				{
						label: "My First dataset",
						fillColor: "rgba(220,220,220,0.5)",
						strokeColor: "rgba(220,220,220,0.8)",
						highlightFill: "rgba(220,220,220,0.75)",
						highlightStroke: "rgba(220,220,220,1)",
						data: [65, 59, 80, 81, 56, 55, 40]
				},
				{
						label: "My Second dataset",
						fillColor: "rgba(151,187,205,0.5)",
						strokeColor: "rgba(151,187,205,0.8)",
						highlightFill: "rgba(151,187,205,0.75)",
						highlightStroke: "rgba(151,187,205,1)",
						data: [28, 48, 40, 19, 86, 27, 90]
				}
		]

		radarchart:
			labels: ["Eating", "Drinking", "Sleeping", "Designing", "Coding", "Cycling", "Running"],
			datasets: [
				{
						label: "My First dataset",
						fillColor: "rgba(220,220,220,0.2)",
						strokeColor: "rgba(220,220,220,1)",
						pointColor: "rgba(220,220,220,1)",
						pointStrokeColor: "#fff",
						pointHighlightFill: "#fff",
						pointHighlightStroke: "rgba(220,220,220,1)",
						data: [65, 59, 90, 81, 56, 55, 40]
				},
				{
						label: "My Second dataset",
						fillColor: "rgba(151,187,205,0.2)",
						strokeColor: "rgba(151,187,205,1)",
						pointColor: "rgba(151,187,205,1)",
						pointStrokeColor: "#fff",
						pointHighlightFill: "#fff",
						pointHighlightStroke: "rgba(151,187,205,1)",
						data: [28, 48, 40, 19, 96, 27, 100]
				}
			]

		onRender: ->
			window.aa = this

			_.delay(@drawChart, 400)
		
		drawChart: =>
			ctx = @ui.barchart.get(0).getContext("2d")
			c = new Chart(ctx).Bar(@bardata)
			
			ctx2 = @ui.radarchart.get(0).getContext("2d")
			c2 = new Chart(ctx2).Radar(@radarchart)

	return ChartsView