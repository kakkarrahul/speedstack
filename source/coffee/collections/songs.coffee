define [
	'backbone'
	'models/song'
], (Backbone, Song)->

	class Songs extends Backbone.Collection
		model: Song

	return Songs