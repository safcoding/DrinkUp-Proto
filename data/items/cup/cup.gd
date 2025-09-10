class_name Cup
extends Node2D

var base:    Ingredient = null
var flavour: Ingredient = null
var topping: Ingredient = null

var stats := {
	"sweetness": 0.0,
	"bitterness": 0.0,
	"creaminess": 0.0,
	"freshness": 0.0,
	"caffeine": 0.0
}

func add_base(ingredient: Ingredient):
	base = ingredient
	_recalculate_stats()
	print_stats()

func add_flavour(ingredient: Ingredient):
	flavour = ingredient
	_recalculate_stats()
	print_stats()

func add_topping(ingredient: Ingredient):
	topping = ingredient
	_recalculate_stats()
	print_stats()
	
func _recalculate_stats():
	for key in stats.keys():
		stats[key]= 0
		
	for ing in [base,flavour,topping]:
		if ing != null:
			var ing_stats = ing.get_stats()
			for key in stats.keys():
				stats[key] += ing_stats.get(key,0)

func print_stats():
	print("---CUP STATS---")
	for key in stats.keys():
		print(key,": ",stats[key])
	print("---CUP STATS---")
		
func get_content():
	if base == null && flavour == null && topping == null:
		print("empty cup")
	else:
		print("Cup: ",base, " ",flavour," ",topping)
	
