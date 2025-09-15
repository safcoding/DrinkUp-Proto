extends Node

var queue_positions: Array[Vector2] = []
var queue_customers: Array = []
var queue_index := 0

func register_markers(markers: Array):
	queue_positions.clear()
	queue_index = 0
	for m in markers:
		queue_positions.append(m.global_position)
	print("Registered queue positions:", queue_positions)

func get_next_queue_pos() -> Vector2:
	if queue_index < queue_positions.size():
		var pos = queue_positions[queue_index]
		queue_index += 1
		return pos
	return Vector2.ZERO

func add_customer(customer) -> Vector2:
	if queue_customers.size() < queue_positions.size():
		queue_customers.append(customer)
		var index = queue_customers.size() - 1
		return queue_positions[index]
	else:
		return Vector2.ZERO  

func remove_customer(customer):
	if customer in queue_customers:
		queue_customers.erase(customer)

func is_first_in_line(customer) -> bool:
	if queue_customers.size() == 0:
		return false
	return queue_customers[0] == customer
