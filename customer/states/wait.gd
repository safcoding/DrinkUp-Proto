extends CustomerState
class_name WaitState

@export var wait_time := 5.0
var waiting := false

func enter(previous_state_path: String, data := {}) -> void:
	customer.go_to("wait")
	await customer.target_reached
	
