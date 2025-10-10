extends CustomerState
class_name OrderState

func enter(previous_state_path: String, data := {}) -> void:
	print("Entered Order State")
	if not customer.markers or not customer.markers.has("order"):
		await get_tree().process_frame  # wait 1 frame
	if not customer.is_connected("order_taken", Callable(self, "accept_order")):
		customer.connect("order_taken", Callable(self, "accept_order"))
	customer.go_to("order")
	await customer.target_reached
	pick_order()

func pick_order():
	var recipe_manager = get_node("/root/RecipeManager")
	var available_recipes = recipe_manager.recipes
	customer.order = available_recipes.pick_random()

func accept_order():
	print("order taken")
	finished.emit("Wait")
