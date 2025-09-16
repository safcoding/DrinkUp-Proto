extends CustomerState
class_name OrderState

func enter(previous_state_path: String, data := {}) -> void:
	pick_order()
	
func pick_order():
	customer.order = customer.drink_options.pick_random()

func accept_order():
	print("exiting order state")
	finished.emit(WAIT)
