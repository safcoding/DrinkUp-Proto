extends Node
class_name AStarController

var astar := AStar2D.new()
var point_ids := {"orderMarker": 1, "waitMarker":2, "pickupMarker":3, "exitMarker":4}

func _ready():
	var id := 0
	for child in get_children():
		if child is Marker2D:
			astar.add_point(id, child.global_position)
			point_ids[child.name] = id
			id += 1

	_connect_points("orderMarker", "waitMarker")
	_connect_points("waitMarker", "pickupMarker")
	_connect_points("pickupMarker", "exitMarker")

	print("✅ AStar navigation graph created with points:", point_ids)

func _connect_points(a: String, b: String):
	if a in point_ids and b in point_ids:
		var a_id = point_ids[a]
		var b_id = point_ids[b]
		astar.connect_points(a_id, b_id, true)

func get_customer_path(from_pos: Vector2, to_pos: Vector2) -> PackedVector2Array:
	var from_id = astar.get_closest_point(from_pos)
	var to_id = astar.get_closest_point(to_pos)
	return astar.get_point_path(from_id, to_id)
