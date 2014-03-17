class Map
	constructor: (map, world) ->
		# Matrix representing the map
		@mapMatrix = CharMatrix(map)

		@world = world

	width: =>
		@mapMatrix[0]?.length or 0

	height: =>
		@mapMatrix.length

	terrain: (pos) =>
		@mapMatrix[pos.y][pos.x]

	cost: (pos) =>
		@world.terrainTypes[@terrain(pos)]

	valid: (pos) =>
		pos.x >= 0 && pos.y >= 0 && pos.x < @width() && pos.y < @height() && @cost(pos) != null

	neighbors: (pos) =>
		neighbors = [
			{x: pos.x - 1, y: pos.y, z: pos.z}
			{x: pos.x + 1, y: pos.y, z: pos.z}
			{x: pos.x, y: pos.y - 1, z: pos.z}
			{x: pos.x, y: pos.y + 1, z: pos.z}
		]

		_.filter neighbors, (neighbor) =>
			@valid(neighbor)


window.Map = Map
