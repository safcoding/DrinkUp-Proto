extends Node
class_name AStarController

var astar := AStar2D.new()
var point_ids := {}

func _ready():
	_register_markers()
	_connect_points()

func _register_markers():
	var id := 1
	for marker in get_children():
		if marker is Marker2D:
			astar.add_point(id, marker.global_position)
			point_ids[marker.name] = id
			id += 1

func _connect_points():
	astar.connect_points(point_ids["orderMarker"], point_ids["waitMarker"])
	astar.connect_points(point_ids["waitMarker"], point_ids["pickupMarker"])
	astar.connect_points(point_ids["pickupMarker"], point_ids["exitMarker"])
	for id in astar.get_point_ids():
		print("Point:", id, "Connected to:", astar.get_point_connections(id))

func get_customer_path(from_pos: Vector2, to_pos: Vector2) -> PackedVector2Array:
	var from = astar.get_closest_point(from_pos)
	var to = astar.get_closest_point(to_pos)
	return astar.get_point_path(from, to)
