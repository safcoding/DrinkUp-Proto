extends CustomerState
class_name WaitState

@onready var wait_timer: Timer = %WaitTimer

@export var wait_time := 5.0
var waiting := false

func enter(previous_state_path: String, data := {}) -> void:
	customer.go_to("wait")
	await customer.target_reached
	wait_timer.start()
	if 
