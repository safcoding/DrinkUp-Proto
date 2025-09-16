extends Node2D
class_name QueueManager

@onready var queue_positions = %QueuePositions.get_children()
@export var arr_limit := 5
var customer_arr: Array = []

func add_customer(customer):
	if customer_arr.size() < arr_limit:
		customer_arr.append(customer)
		# Connect the signal so when the customer leaves, QueueManager handles cleanup
		if not customer.is_connected("customer_left", Callable(self, "_on_customer_left")):
			customer.connect("customer_left", Callable(self, "_on_customer_left"))

		var queue_index = customer_arr.size() - 1
		customer.target_position = queue_positions[queue_index].global_position

func _on_customer_left(customer):
	print("Customer leaving -> removing from queue:", customer)
	customer_arr.erase(customer)  # Remove from the array
	customer.queue_free()         # Free the node
	update_queue()                # Shift others forward

func remove_customer():
	if customer_arr.size() > 0:
		print("popping customer manually")
		var customer = customer_arr.pop_front()
		customer.queue_free()
		update_queue()

func update_queue():
	print("updating queue")
	for i in range(customer_arr.size()):
		var customer = customer_arr[i]
		customer.target_position = queue_positions[i].global_position

func queue_check() -> bool:
	return customer_arr.size() >= arr_limit

func get_front_customer():
	if customer_arr.size() > 0:
		return customer_arr[0]
	return null
