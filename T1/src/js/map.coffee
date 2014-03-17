positionFromArray = (arr) ->
	x: arr[0]
	y: arr[1]
	z: arr[2]

class Map
	constructor: (str, terrainTypes) ->
		@terrainTypes = terrainTypes

		[index, mapStr] = str.trim().split('\n---\n')

		# Index of the map
		@index = +index

		# Matrix representing the map
		@mapMatrix = CharMatrix(mapStr)

	width: =>
		@mapMatrix[0]?.length or 0

	height: =>
		@mapMatrix.length

	terrain: (pos) =>
		@mapMatrix[pos.y][pos.x]

	cost: (pos) =>
		@terrainTypes[@terrain(pos)]

	valid: (pos) =>
		pos.x >= 0 && pos.y >= 0 && pos.x < @width() && pos.y < @height() && @cost(pos) != Infinity

	neighbors: (pos) =>
		neighbors = [
			{x: pos.x - 1, y: pos.y, z: @index}
			{x: pos.x + 1, y: pos.y, z: @index}
			{x: pos.x, y: pos.y - 1, z: @index}
			{x: pos.x, y: pos.y + 1, z: @index}
		]

		_.filter neighbors, (neighbor) =>
			@valid(neighbor)


window.Map = Map
