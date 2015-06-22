define [
	'backbone'
	'models/song'
], (Backbone, Song)->

	music_server = 'http://localhost:4300/'

	class Songs extends Backbone.Collection
		model: Song
		
		initialize: ->
			if !chrome.runtime.reload
				@url = '/js/songs.json'	
			else
				@url = '/public/js/songs.json'	

		trimStartSlash: (str)->
			if str[str.length-1] is '/'
				return str.substring 0, str.length-1
			else
				return str
		
		parse: (data)->
			@music_dir = @trimStartSlash data.music_dir
			return data.entries.map (k)=>
				k.path = @trimStartSlash(music_server) + encodeURI(k.path.replace(@music_dir, ''))
				return k

	return new Songs()