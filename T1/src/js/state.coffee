class State
	@fromState = (previousState, position) ->
		# Throw if the new position is not a neighbor of the previous one
		do ->
			neighbors = previousState.world.neighbors(previousState.position...)
			for neighbor in neighbors
				if _.isEqual(neighbor, position)
					return true
			throw new Error("New position is invalid! Valid neighbors are: #{JSON.stringify(neighbors)}.")

		state = new this(previousState.world, position, previousState.objective, previousState.cost)

		# Add previous state to the history
		state.history = _.cloneDeep(previousState.history)
		state.history.push(position)

		# If we're at the objective, we're done
		state.finished = previousState.finished || _.isEqual(state.position, state.objective)

		# Update cost using terrain
		state.cost = previousState.cost + state.world.cost(position...)

		state

	constructor: (world, position, objective) ->
		@world = world
		@position = _.clone(position)
		@objective = objective
		@history = [position]
		@cost = 0
		@finished = false

	distance: =>
		@world.distance(@position, @objective)

	possibilities: =>
		@world.neighbors(@position...)

	heuristic: =>
		# Underestimate the total cost to the objective.
		@cost + (@world.cheapestTerrain * @distance())

	toString: =>
		"""
		At position [#{@position}], with accumulated cost of #{@cost}. Distance to objective (#{@objective}): #{@distance()}.
		History: #{JSON.stringify(@history)}."
		"""


window.State = State
