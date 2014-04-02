window.heuristicSearch = (world, start, end) ->

	# Automatic ordered
	states = new Heap (a, b) -> a.heuristic() - b.heuristic()

	marker = new WorldMarker(world)

	initial = new State(world, start, end)
	states.push(initial)

	log = []
	while true
		current = states.pop()
		log.push(['visited', current.position])
		for possibility in current.possibilities() when not marker.isMarked(possibility)
			marker.mark(possibility)
			log.push(['frontier', possibility])
			next = State.fromState(current, possibility)
			states.push next
			if next.finished
				_.each next.history, (position) ->
					log.push ['final', position]
				return {
					searchLog: log
					pathFound: _.cloneDeep(next.history)
					cost: next.cost
				}
