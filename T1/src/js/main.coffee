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

$(window).on 'app.ready', ->
	window.renderer = new Renderer($('div'), world)

	# Points of interest
	poi =
		start: [24, 27, 0]
		door01: [5, 32, 0]
		obj1: [13, 3, 1]
		door10: [14, 26, 1]
		door02: [39, 17, 0]
		obj2: [13, 2, 2]
		door20: [13, 25, 2]
		door03: [24, 1, 0]
		obj3: [15, 19, 3]
		door30: [14, 25, 3]
		sword: [2, 1, 0]

	# Composable paths
	window.components = [
		{fromName: 'start', toName: 'door01'}
		{fromName: 'start', toName: 'door02'}
		{fromName: 'start', toName: 'door03'}
		{fromName: 'door01', toName: 'door02'}
		{fromName: 'door01', toName: 'door03'}
		{fromName: 'door02', toName: 'door03'}
		{fromName: 'door10', toName: 'obj1'}
		{fromName: 'door20', toName: 'obj2'}
		{fromName: 'door30', toName: 'obj3'}
		{fromName: 'door01', toName: 'sword'}
		{fromName: 'door02', toName: 'sword'}
		{fromName: 'door03', toName: 'sword'}
	]

	console.time('all')
	_.each components, (component) ->
		console.time("#{component.fromName} -> #{component.toName}")

		[start, end] = [poi[component.fromName], poi[component.toName]]
		[component.log, component.answer] = heuristicSearch(start, end, world)

		console.timeEnd("#{component.fromName} -> #{component.toName}")
	console.timeEnd('all')


#	_.reduce components, (baseDelay, component) ->
#		return baseDelay + renderer.renderSearch(component, baseDelay)
#	, 0

	_.each components, (component) ->
		newComponent =
			fromName: component.toName
			toName: component.fromName
			answer: _.cloneDeep(component.answer)
		newComponent.answer.history.reverse()
		components.push newComponent

	subPaths = {
		1: ['door01', 'door10', 'obj1', 'door10', 'door01']
		2: ['door02', 'door20', 'obj2', 'door20', 'door02']
		3: ['door03', 'door30', 'obj3', 'door30', 'door03']
	}

	possibleSolutions = [
		{interests: ['start'].concat(subPaths[1]).concat(subPaths[2]).concat(subPaths[3]).concat(['sword'])}
		{interests: ['start'].concat(subPaths[1]).concat(subPaths[3]).concat(subPaths[2]).concat(['sword'])}
		{interests: ['start'].concat(subPaths[2]).concat(subPaths[1]).concat(subPaths[3]).concat(['sword'])}
		{interests: ['start'].concat(subPaths[2]).concat(subPaths[3]).concat(subPaths[1]).concat(['sword'])}
		{interests: ['start'].concat(subPaths[3]).concat(subPaths[1]).concat(subPaths[2]).concat(['sword'])}
		{interests: ['start'].concat(subPaths[3]).concat(subPaths[2]).concat(subPaths[1]).concat(['sword'])}
	]

	_.each possibleSolutions, (possibleSolution) ->
		possibleSolution.path = []
		possibleSolution.cost = 0
		for curr, i in possibleSolution.interests
			prev = possibleSolution.interests[i-1]
			if prev
				component = _.find components, (component) ->
					component.fromName == prev && component.toName == curr
				if component
					possibleSolution.path.push(component.answer.history...)
					possibleSolution.cost += component.answer.cost

	window.solution = _.min possibleSolutions, 'cost'
