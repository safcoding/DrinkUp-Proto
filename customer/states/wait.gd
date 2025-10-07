extends CustomerState
class_name WaitState

@export var wait_time := 5.0
var has_arrived := false
var waiting := false

func enter(previous_state_path: String, data := {}) -> void:
	print("Customer entered WaitState")

	if data.has("target_pos"):
		customer.set_target_location(data["target_pos"])
	else:
		print("⚠️ No target position provided!")

func physics_update(delta: float) -> void:
	if not has_arrived and customer.arrived_at_location():
		has_arrived = true
		_on_customer_arrived()

func _on_customer_arrived() -> void:
	print("Customer arrived at waiting spot")
	waiting = true
	customer.velocity = Vector2.ZERO
	customer.wait_timer.start(wait_time)

func update(delta: float) -> void:
	if waiting and not customer.wait_timer.is_stopped():
		# Could add waiting animation here
		pass
	elif waiting and customer.wait_timer.is_stopped():
		waiting = false
		finished.emit("res://path/to/OrderState.gd", {"customer": customer})
