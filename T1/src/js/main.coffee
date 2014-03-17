terrainTypes =
	F: 100
	G: 10
	S: 20
	M: 150
	W: 180
	D: Infinity
	L: 10

world = new World(terrainTypes)

window.terrainTypes = terrainTypes
window.world = world

Renderer = DOMRenderer

maps = 'map dun1 dun2 dun3'.split(' ')
promises = _.map maps, (map) ->
	$.ajax("/data/#{map}.txt").success (data) ->
		world.addMap(new Map(data, terrainTypes))
promises.push $.getJSON("/data/data.json").success (data) ->
	world.paths = new Paths(data)
	world.icons = data.icons

$.when(promises...).then ->
	$(window).trigger('app.ready')

$(window).on 'app.ready', ->
	window.renderer = new Renderer($('div'), world)

	console.time('all')
	_.each world.paths.components, (component) ->
		name = "#{JSON.stringify component.from} -> #{JSON.stringify component.to}"
		console.time(name)

		_.extend component, heuristicSearch(world, component.from, component.to)

		console.timeEnd(name)
	console.timeEnd('all')

#	_.reduce world.paths.components, (baseDelay, component) ->
#		return baseDelay + renderer.renderSearch(component, baseDelay)
#	, 0

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
