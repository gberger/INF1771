Matrix = (rows, cols, defaultValue) ->
	arr = []
	i = 0
	while i < rows
		arr.push []
		arr[i].push new Array(cols)
		if defaultValue isnt undefined
			j = 0
			while j < cols
				arr[i][j] = defaultValue
				j++
		i++
	arr


window.Matrix = Matrix
