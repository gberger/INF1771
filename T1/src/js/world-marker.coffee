class WorldMarker
	constructor: (world) ->
		@marks = _.map world.maps, (map) ->
			Matrix(map.height(), map.width(), false)

	mark: (pos) =>
		@marks[pos.z][pos.y][pos.x] = true

	isMarked: (pos) =>
		@marks[pos.z][pos.y][pos.x]


window.WorldMarker = WorldMarker
