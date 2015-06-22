define ['backbone'], (Backbone)->

	class Song extends Backbone.Model
		query_url: 'https://itunes.apple.com/search?term=__query__&limit=5'
		toQuery: ->
			str = "#{@get('title')}+#{@get('album_artist')}"
			return str.replace(/ /g, '+')

		logError: (err)->
			console.error 'NowPlaying: Fetch failed.', err
		
		fetchData: ->
			query = do @toQuery
			url = @query_url.replace '__query__', query
			
			return (
				Promise
				.resolve $.getJSON(url)
					.catch @logError
				.then (resp)=>
					if !resp or !resp.results.length
						return $.error('Could\'nt fetch api response')
					else	
						return @set resp.results[0]
			)

	return Song