class WorldMarker
	constructor: (world) ->
		@marks = _.map world.maps, (map) ->
			Matrix(map.height(), map.width(), false)

	mark: (x, y, index) =>
		@marks[index][x][y] = true

	isMarked: (x, y, index) =>
		@marks[index][x][y]


window.WorldMarker = WorldMarker