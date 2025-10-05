extends Node

var recipes: Array[Recipe] = []

func _ready():
	load_recipes()

func register_recipe(recipe: Recipe):
	recipes.append(recipe)

func load_recipes():
	var dir = DirAccess.open("user://recipes")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var r: Recipe = load("user://recipes/" + file_name)
				recipes.append(r)
				print(file_name, " added")
			file_name = dir.get_next()
