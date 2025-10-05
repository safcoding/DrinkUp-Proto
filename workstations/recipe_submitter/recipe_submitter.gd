extends Node2D

@onready var recipe_manager = get_node("/root/RecipeManager")
var player: Node2D = null

func _process(delta):
	if player != null:
		if Input.is_action_just_released("interact"):
			var held = player.inventory.get_item()
			if held != null:
				submit_drink(held)
			elif held == null:
				print("nothing held")

		
		
func submit_drink(cup):
	var recipe = Recipe.new()
	recipe.id = str(Time.get_unix_time_from_system()) # unique-ish id
	recipe.name = "Custom Drink" # could prompt player for a name
	recipe.ingredients = {
		"base": cup.base,
		"flavour": cup.flavour,
		"topping": cup.topping
	}
	recipe.active = true
	var save_path = "user://recipes/%s.tres" % recipe.id
	ResourceSaver.save(recipe, save_path)
	recipe_manager.register_recipe(recipe)
	print("new recipe", recipe.name, " | ",recipe.ingredients )


func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null
