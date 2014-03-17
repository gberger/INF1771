class Paths
	constructor: (data) ->
		@aliases = data.aliases
		@solutions = data.solutions
		@parseAliases()
		@extractComponents()

	resolve: (path) =>
		resolved = []
		for part in path
			if _.isString(part)
				resolved = resolved.concat(@aliases[part])
			else
				resolved.push(part)
		return resolved

	parseAliases: =>
		for name, definition of @aliases
			@aliases[name] = @resolve(definition)
		@solutions = _.map @solutions, (solution) =>
			@resolve(solution)

	extractComponents: =>
		@components = []
		for solution in @solutions
			for curr, i in solution when i > 0
				prev = solution[i-1]
				if prev.z == curr.z
					any = _.any @components, (component) =>
						(_.isEqual(component.from, prev) && _.isEqual(component.to, curr)) ||
						(_.isEqual(component.from, curr) && _.isEqual(component.to, prev))
					unless any
						@components.push from: prev, to: curr
		@components = _.uniq @components, (component) ->
			JSON.stringify(component.from) + JSON.stringify(component.to)

	buildReverseComponents: =>
		@components = @components.concat _.map @components, (component) ->
			newComponent =
				from: component.to
				to: component.from
				searchLog: []
				cost: component.cost
				pathFound: _.clone(component.pathFound)
			newComponent.pathFound.reverse()
			newComponent


window.Paths = Paths