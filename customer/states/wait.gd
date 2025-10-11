extends CustomerState

@export var serving_counter: NodePath  # assign in editor or pass via code
@onready var counter: Node = get_node(serving_counter)

func enter(previous_state_path: String, data := {}) -> void:
	customer.go_to("wait")
	await customer.target_reached
	print("Customer reached waiting spot, waiting for drink...")

	await customer.serve_counter.drink_ready
	print("Drink ready, going to pickup")

	finished.emit("Pickup")
