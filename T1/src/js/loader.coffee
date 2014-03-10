maps = 'map dun1 dun2 dun3'.split(' ')
promises = _.map maps, (map) ->
	$.ajax("/data/#{map}.txt").success (data) ->
		world.addMap(new Map(data, terrainTypes))

$.when(promises...).then ->
	$(window).trigger('app.ready')
