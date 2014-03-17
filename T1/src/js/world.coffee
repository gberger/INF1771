class World
	constructor: (@terrainTypes) ->
		@maps = {}

		@cheapestTerrain = _.min(@terrainTypes)

		# Delegate these functions to the appropriate map
		'width height terrain neighbors cost'.split(' ').forEach (fn) =>
			@[fn] = do (fn) => (pos) =>
				# Throw if no such map
				throw new Error("No map with such z: #{pos.z}.") unless !!@maps[pos.z]
				@maps[pos.z][fn](pos)

	addMap: (mapStr, z) =>
		@maps[z] = new Map(mapStr, @)

	distance: (from, to) =>
		throw new Error("Can't calculate distance with different indexes") if from.z != to.z
		return Math.abs(from.x - to.x) + Math.abs(from.y - to.y)


window.World = World
