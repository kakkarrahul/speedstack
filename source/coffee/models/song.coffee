define ['backbone'], (Backbone)->

	class Song extends Backbone.Model
		defaults:
			title: 'No Title'
			albumartist: 'No Artist'
			year: '-'

	return Song