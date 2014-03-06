_ = require 'lodash'
w = require 'word-array'
fs = require 'fs'

class Map
	constructor: (str) ->
		[index, mapStr, doorsStr] = str.trim().split('---')

		# Index of the map
		@index = +index.trim()

		# Matrix representing the map
		@mapMatrix = mapStr.trim().split('\n').map (l) -> l.split('')

		# Array of objects with properties 'from' and 'to', both 3-dimensional coordinates
		@doors = _.reduce doorsStr.trim().split('\n'), (doors, door) =>
			[from, to] = door.split('->')
			doors.push
				from: from.split(' ')
				to: to.split(' ')
			doors
		, []

	width: =>
		@mapMatrix.length

	height: =>
		@mapMatrix[0].length

	terrain: (x, y) =>
		@mapMatrix[x][y]

	door: (x, y) =>
		_.find @doors, (door) ->
			door.from[0] == x && door.from[1] == y

	doorTo: (index) =>
		_.find @doors, (door) ->
			door.to[2] == index

	neighbors: (x, y, index) =>
		neighbors = []
		unless x == 0
			neighbors.push [x-1, y, index]
		unless x == @width()
			neighbors.push [x+1, y, index]
		unless y == 0
			neighbors.push [x, y-1, index]
		unless y == @width()
			neighbors.push [x, y+1, index]
		if !!@door(x, y)
			neighbors.push @door(x, y)
		neighbors

class World
	constructor: (@terrainTypes) ->
		@maps = {}

		# Delegate these functions to the appropriate map
		w('width height terrain door neighbors').forEach (fn) =>
			@[fn] = do (fn) => (x, y, index) =>
				# Throw if no such map
				throw new Error("No map with such index: #{index}.") unless index+'' in _.keys(@maps)
				@maps[index][fn](x, y, index)

	addMap: (map) =>
		@maps[map.index] = map

	cost: (x, y, index) =>
		@terrainTypes[@terrain(x, y, index)]

	distance: (x, y, index, xx, yy, iindex) =>
		if index == iindex
			Math.abs(x-xx) + Math.abs(y-yy)

readMap = (filename) ->
	new Map(fs.readFileSync(filename).toString())

terrainTypes =
	F: 100
	G: 10
	S: 20
	M: 150
	W: 180
	D: Infinity
	L: 10
w = new World(terrainTypes)
w.addMap(overworld = readMap('./src/data/map.txt'))
w.addMap(dungeon1  = readMap('./src/data/dun1.txt'))
w.addMap(dungeon2  = readMap('./src/data/dun2.txt'))
w.addMap(dungeon3  = readMap('./src/data/dun3.txt'))


class State
	@fromState = (previousState, position) ->
		# Throw if the new position is not a neighbor of the previous one
		do ->
			neighbors = previousState.world.neighbors(previousState.position...)
			for neighbor in neighbors
				if _.isEqual(neighbor, position)
					return true
			throw new Error("New position is invalid! Valid neighbors are: #{JSON.stringify(neighbors)}.")

		state = new this(previousState.world, position, previousState.objectives, previousState.cost)

		# Add previous state to the history
		state.history = _.cloneDeep(previousState.history)
		state.history.push(previousState.position)

		# Eliminate an objective from the first objective group if we reached it
		state.objectives[0] = _.filter state.objectives[0], (objective) ->
			!_.isEqual(objective, state.position)

		# Eliminate an objective group if it's empty
		state.objectives = _.filter state.objectives, (objectiveGroup) -> objectiveGroup.length != 0

		# Update cost using terrain
		state.cost = previousState.cost + state.world.cost(position...)

		# Update distance to closests objective
		state.distance = _.chain(state.objectives).first().map (objective) ->
			state.world.distance(position..., objective...)
		.min().value()

		state

	constructor: (world, position, objectives) ->
		@world = world
		@position = _.clone(position)
		@objectives = _.cloneDeep(objectives)
		@history = []
		@cost = 0

	toString: =>
		"""
		At position [#{@position}], with accumulated cost of #{@cost}. Distance to closest objective: #{@distance}.
		Remaining objectives:
		#{@objectives.map((objectiveGroup) -> ' - ' + objectiveGroup.map(JSON.stringify).join(' + ')).join('\n')}
		History: #{JSON.stringify(@history)}."
		"""
s = new State(w, [1, 1, 0], [[ [1, 0, 0] ] , [ [5, 5, 0], [10, 10, 0] ]])
console.log State.fromState(State.fromState(s, [1, 0, 0]), [1, 1, 0]).toString()
