class World
	constructor: (@terrainTypes) ->
		@maps = {}

		@cheapestTerrain = _.min(@terrainTypes)

		# Delegate these functions to the appropriate map
		'width height terrain door neighbors mark isMarked clearMarks'.split(' ').forEach (fn) =>
			@[fn] = do (fn) => (x, y, index) =>
				# Throw if no such map
				throw new Error("No map with such index: #{index}.") unless index+'' in _.keys(@maps)
				@maps[index][fn](+x, +y)

	addMap: (map) =>
		@maps[map.index] = map

	cost: (x, y, index) =>
		@terrainTypes[@terrain(x, y, index)]

	distance: (from, to) =>
		# Manhattan distance - auxiliary
		manhattan = (x1, x2, y1, y2) ->
			Math.abs(x1 - x2) + Math.abs(y1 - y2)

		# path is an array of (x, y, z)-tuples
		path = @findPath(from, to)

		return _.reduce path, (distance, current, i) ->
			if i > 0
				previous = path[i-1]
				if current[2] == previous[2]
					# Same map
					distance += manhattan(previous[0], current[0], previous[1], current[1])
				else
					# Different maps, door transition
					distance += 1
			return distance
		, 0

	findPath: (from, to) =>
		path = [from]

		if from[2] == to[2]
			# Same map
			path.push(to)
			return path
		else if !!(door = @maps[from[2]].doorTo(to[2]))
			# Direct door
			path.push(door.from)
			return path.concat(@findPath(door.to, to))
		else
			# Try each door. If we exceed stack size (RangeError), catch it and try another door.
			for door in @maps[index].doors
				try
					p = @findPath(door.to, to)
					if _.last(p)[2] == iindex
						path.push(door.from)
						return path.concat(p)
				catch error
					throw error if not error instanceof RangeError


window.World = World
