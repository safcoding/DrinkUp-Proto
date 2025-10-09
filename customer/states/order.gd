extends CustomerState
class_name OrderState

func enter(previous_state_path: String, data := {}) -> void:
	customer.go_to("order")
	pick_order()
	
func pick_order():
	var recipe_manager = get_node("/root/RecipeManager")
	var available_recipes = recipe_manager.recipes

	customer.order = available_recipes.pick_random()
	print("Customer ordered:", customer.order.name)
	
func accept_order():
	print("exiting order state")
	await customer.emit_signal("order_accepted")
	finished.emit("Wait")
