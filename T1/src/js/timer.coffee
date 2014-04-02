window.timers = {}

do ->
	inProgress = {}

	window.time = (name) ->
		if !inProgress[name]
			inProgress[name] = +new Date()

	window.timeEnd = (name) ->
		if inProgress[name]
			timers[name] = (+new Date) - inProgress[name]
			console.log("#{name}: #{timers[name]}ms")
			delete inProgress[name]
		return timers[name]