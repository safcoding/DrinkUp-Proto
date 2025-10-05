extends State

@export var customer: Customer
@onready var wait_area = get_tree().get_first_node_in_group("WaitArea")

var assigned_marker: Marker2D = null

func enter(previous_state_path: String, data := {}) -> void:
	assigned_marker = wait_area.get_available_marker()
	if assigned_marker:
		customer.set_target_location(assigned_marker.global_position)
		customer.connect("target_reached", Callable(self, "_on_customer_arrived"), CONNECT_ONE_SHOT)
	else:
		print("⚠ No free markers available!")

func exit() -> void:
	if assigned_marker:
		wait_area.release_marker(assigned_marker)
		assigned_marker = null
