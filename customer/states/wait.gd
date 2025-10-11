extends CustomerState
class_name WaitState

@export var wait_time := 5.0
var waiting := false

func enter(previous_state_path: String, data := {}) -> void:
	customer.go_to("wait")
	await customer.target_reached
	print("timer starts")
	if not customer.is_connected("drink_ready", Callable(self, "pickup_drink")):
		customer.connect("drink_ready", Callable(self, "pickup_drink"))

func update(_delta:float):
	if emit_signal("drink_ready"):
		waiting = false
		print("timer ends")
		customer.go_to("pickup")
	
