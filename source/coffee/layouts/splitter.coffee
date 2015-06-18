define [
	'underscore'
	'data_in'
], (_, input)->

	products = []

	toProducts = (inp)->
		results = []
		_.each inp.interest_rates.map, (d)->
			prod = _.omit(inp, 'interest_rates')
			prod.interest_rates = d
			results.push prod
		return results

	
	input.map (inp)->
		if inp.interest_rates.length > 1
			prods = toProducts inp
			products.concat prods
		else
			products.push inp

	return products
