class DOMRenderer
	constructor: (element, world) ->
		@element = element
		@world = world

		@allClasses = 'frontier visited final'
		@build()

	build: =>
		@element.addClass('dom-renderer')
		maps = _.map @world.maps, (m) -> m.mapMatrix
		_.each maps, (map, z) =>
			table = $('<div class="map"></div>')
			_.each map, (row, y) ->
				tr = $('<div class="row"></div>')
				_.each row, (cell, x) ->
					td = $("<div class='cell #{cell}' id='dom-cell-#{x}-#{y}-#{z}'><div class='sub'>&nbsp;</div></div>")
					tr.append(td)
				table.append(tr)
			@element.append(table)
		_.each @world.objectives(), (objective) =>
			@getSub(objective...).html('<i class="fa fa-star"></i>')
		_.each @world.doors(), (door) =>
			@getSub(door.from...).html('<i class="fa fa-reply"></i>')

	finished: =>
		console.log 'finished', hub.log

	get: (x, y, z) =>
		$("\#dom-cell-#{x}-#{y}-#{z}")

	getSub: (x, y, z) =>
		@get(x, y, z).find('.sub')

	clear: =>
		$('.sub').removeClass(@allClasses)

	renderSearch: (component, baseDelay = 0, unitDelay = 5) =>
		# Clear at the start
		setTimeout =>
			@clear()
		, baseDelay

		_.delayedEach component.log, baseDelay, unitDelay, (event) =>
			[klass, coords] = event
			@getSub(coords...).removeClass(@allClasses).addClass(klass)
		return unitDelay * component.log.length

	renderMovement: (path, baseDelay = 0, unitDelay = 5) =>
		@clear()
		_.delayedEach path, baseDelay, unitDelay, (coords) =>
			@clear()
			@getSub(coords...).removeClass(@allClasses).addClass('final')
		return unitDelay * path.length


window.DOMRenderer = DOMRenderer
