extends CustomerState
class_name LeaveState

func enter(previous_state_path: String, data := {}) -> void:
	await get_tree().process_frame 
	customer.go_to("exit")
	await customer.target_reached
	customer.queue_free()
