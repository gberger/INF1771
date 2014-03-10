class World
	constructor: (@terrainTypes) ->
		@maps = {}

		@cheapestTerrain = _.min(@terrainTypes)

		# Delegate these functions to the appropriate map
		'width height terrain door neighbors cost'.split(' ').forEach (fn) =>
			@[fn] = do (fn) => (x, y, index) =>
				# Throw if no such map
				throw new Error("No map with such index: #{index}.") unless index+'' in _.keys(@maps)
				@maps[index][fn](+x, +y)

	addMap: (map) =>
		@maps[map.index] = map

	doors: =>
		_.reduce @maps, (doors, map) ->
			doors.concat(map.doors)
		, []

	objectives: =>
		_.reduce @maps, (objectives, map) ->
			objectives.concat(map.objectives)
		, []

	distance: (from, to) =>
		[x1, y1, z1] = from
		[x2, y2, z2] = to
		throw new Error("Can't calculate distance with different indexes") if z1 != z2
		return Math.abs(x1 - x2) + Math.abs(y1 - y2)


window.World = World
