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
					td = $("<div class='cell #{cell}' id='pos-#{x}-#{y}-#{z}'><div class='sub'>&nbsp;</div></div>")
					tr.append(td)
				table.append(tr)
			@element.append(table)
		_.each @world.icons, (icon) =>
			type = {"star": "star", "door": "reply"}[icon.type]
			@getSub(icon.position).html("<i class='fa fa-#{type}'></i>")

	get: (pos) =>
		$("\#pos-#{pos.x}-#{pos.y}-#{pos.z}")

	getSub: (pos) =>
		@get(pos).find('.sub')

	clear: =>
		$('.sub').removeClass(@allClasses)

	renderSearch: (component, baseDelay = 0, unitDelay = 5) =>
		# Clear at the start
		setTimeout =>
			@clear()
		, baseDelay

		_.delayedEach component.searchLog, baseDelay, unitDelay, (event) =>
			[klass, pos] = event
			@getSub(pos).removeClass(@allClasses).addClass(klass)
		return unitDelay * component.searchLog.length

	renderMovement: (path, baseDelay = 0, unitDelay = 5) =>
		@clear()
		_.delayedEach path, baseDelay, unitDelay, (coords) =>
			@clear()
			@getSub(coords).removeClass(@allClasses).addClass('final')
		return unitDelay * path.length


window.DOMRenderer = DOMRenderer
