extends CustomerState
class_name PickupState

func enter(previous_state_path: String, data := {}) -> void:
	customer.current_target = customer.serve_counter
	await customer.target_reached
	Global.player_money += 3
	print ("Money: ",Global.player_money)
	finished.emit("Leave")
