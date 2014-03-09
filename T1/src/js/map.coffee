class Map
	constructor: (str) ->
		[index, mapStr, doorsStr] = str.trim().split('\n---\n')

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

	width: =>
		@mapMatrix[0]?.length or 0

	height: =>
		@mapMatrix.length

	terrain: (x, y) =>
		@mapMatrix[y][x]

	door: (x, y) =>
		_.find @doors, (door) ->
			door.from[0] == x && door.from[1] == y

	doorTo: (index) =>
		_.find @doors, (door) ->
			door.to[2] == index

	neighbors: (x, y) =>
		neighbors = []
		unless x == 0
			neighbors.push [x-1, y, @index]
		unless x == @width() - 1
			neighbors.push [x+1, y, @index]
		unless y == 0
			neighbors.push [x, y-1, @index]
		unless y == @width() - 1
			neighbors.push [x, y+1, @index]
		if !!@door(x, y)
			neighbors.push @door(x, y).to
		neighbors

	mark: (x, y) =>
		@markedMatrix[x][y] = true

	isMarked: (x, y) =>
		@markedMatrix[x][y]

	clearMarks: =>
		@markedMatrix = Matrix(@height(), @width(), false)


window.Map = Map
