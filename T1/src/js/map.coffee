class Map
	constructor: (str, terrainTypes) ->
		@terrainTypes = terrainTypes

		[index, mapStr, doorsStr, objectivesStr] = str.trim().split('\n---\n')

		# Index of the map
		@index = +index

		# Matrix representing the map
		@mapMatrix = CharMatrix(mapStr)

		@markedMatrix = Matrix(@height(), @width(), false)

		# Array of objects with properties 'from' and 'to', both 3-dimensional coordinates
		@doors = _.reduce doorsStr.split('\n'), (doors, door) =>
			[from, to] = door.split('->')
			doors.push
				from: from.split(' ').map (n) -> +n
				to: to.split(' ').map (n) -> +n
			doors
		, []

		# Array of objectives
		@objectives = _.map objectivesStr.trim().split('\n'), (obj) -> obj.split(' ')

	width: =>
		@mapMatrix[0]?.length or 0

	height: =>
		@mapMatrix.length

	terrain: (x, y) =>
		@mapMatrix[y][x]

	cost: (x, y) =>
		@terrainTypes[@terrain(x, y)]

	valid: (x, y) =>
		x >= 0 && y >= 0 && x < @width() && y < @height() && @cost(x, y) != Infinity

	door: (x, y) =>
		_.find @doors, (door) ->
			door.from[0] == x && door.from[1] == y

	doorTo: (index) =>
		_.find @doors, (door) ->
			door.to[2] == index

	neighbors: (x, y) =>
		neighbors = [[x-1, y, @index], [x+1, y, @index], [x, y-1, @index], [x, y+1, @index]]

		_.filter neighbors, (neighbor) =>
			@valid(neighbor...)


window.Map = Map
