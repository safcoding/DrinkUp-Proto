extends CustomerState
class_name WaitState

func enter(previous_state_path: String, data := {}) -> void:
	print("in wait state")
	customer.target_pos = customer.wait_area.global_position
	var timer = customer.wait_timer
	timer.start()
	
func physics_update(_delta: float) -> void:
	customer.dir = customer.target_pos - customer.global_position
	var dir = customer.dir
	if dir.length() >= 2.0:
		customer.velocity = dir.normalized() * customer.speed
		customer.move_and_slide()
	else:
		customer.velocity = Vector2.ZERO

func exit():
	pass
