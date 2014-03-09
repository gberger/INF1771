
terrainTypes =
	F: 100
	G: 10
	S: 20
	M: 150
	W: 180
	D: Infinity
	L: 10
w = new World(terrainTypes)

maps = 'map dun1 dun2 dun3'.split(' ')
promises = _.map maps, (map) ->
	$.get("/data/#{map}.txt").finished (data) ->
		w.addMap(new Map(data))

$.when(promises...).then ->
	states = new Heap (a, b) -> a.heuristic() - b.heuristic()

	start = [24, 27, 0]
	ping1 = [13, 3, 1]
	ping2 = [13, 2, 2]
	ping3 = [15, 19, 3]
	sword = [2, 1, 0]
	s = new State(w, start, ping1)

	states.push(s)

	finish = do ->
		while true
			state = states.pop()
			for possibility in state.possibilities() when not w.isMarked(possibility...)
				w.mark(possibility...)
				s = State.fromState(state, possibility)
				if s.finished
					return s
				states.push s

	console.log finish.toString()
