define [
	'marionette'
	'radio'
	'./tpl-view'
	'css!./style'
], (Marionette, Radio, tpl)->
	
	player = Radio.channel 'player'

	class BackgroundView extends Marionette.ItemView
		template: tpl
		className: 'view-bg'
		ui:
			container: '.bg-container'
		
		initialize: ->
			@listenTo player, 'data:fetched', @swapBackgrounds
		
		g_images_url: "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&imgsz=xxlarge&q=__QUERY__"
		swapBackgrounds: (song)->
			q = "#{song.get('artistName')} wallpaper"
			url = @g_images_url.replace '__QUERY__', encodeURI(q)
			
			@ui.container.removeClass 'is-visible'

			Promise.resolve($.getJSON(url))
				.then @pickImage
				.then @showImage
				.catch (err)-> console.error('Cannot fetch: ', err)

		pickImage: (response)=>
			url = response.responseData.results[0].url
			return url
		showImage: (url)=>
			fetch_blob(url).then (blob_url)=>
				@ui.container
					.css 'background-image', "url('" + blob_url + "')"
					.addClass 'is-visible'

	return BackgroundView