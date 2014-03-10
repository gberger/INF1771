_.mixin
	delayedEach: (list, baseDelay, unitDelay, callback) ->
		clone = _.clone(list)
		for item, i in clone
			do (item, i) ->
				setTimeout ->
					callback(item, i, clone)
				, baseDelay + (unitDelay * (i+1))