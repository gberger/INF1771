$.getJSON("/data/data.json").success (data) ->
	world = new World(data.terrainTypes)
	world.paths = new Paths(data)
	world.icons = data.icons
	for map, i in data.maps
		world.addMap(map.join('\n'), i)
	main(world)

main = (world) ->
	time('all')
	_.each world.paths.components, (component) ->
		time(component.name)

		_.extend component, heuristicSearch(world, component.from, component.to)

		component.time = timeEnd(component.name)
	timeAll = timeEnd('all')

	window.renderer = new DOMRenderer($('div'), world)
	window.renderer.setExecTime(timeAll)

	world.paths.buildReverseComponents()

	window.possibleSolutions = _.map world.paths.solutions, (solution) ->
		possibleSolution = {cost: 0, pathFound: []}
		for curr, i in  solution when i > 0
			prev = solution[i-1]
			component = _.find world.paths.components, (component) ->
				_.isEqual(component.from, prev) && _.isEqual(component.to, curr)
			if component
				possibleSolution.cost += component.cost
				possibleSolution.pathFound = possibleSolution.pathFound.concat _.cloneDeep(component.pathFound)
		possibleSolution


	window.solution = _.min possibleSolutions, 'cost'
	window.renderer.setSolution(solution)
