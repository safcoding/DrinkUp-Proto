extends Node2D

@export var customer_scene: PackedScene
@onready var enter_marker: Marker2D = %enterMarker
@onready var order_marker: Marker2D = %orderMarker
@onready var wait_marker: Marker2D = %waitMarker
@onready var pickup_marker: Marker2D = %pickupMarker
@onready var exit_marker: Marker2D = %exitMarker

@onready var serve_counter: ServeCounter = %ServeCounter

func spawn_customer():
	var customer = customer_scene.instantiate()
	get_tree().current_scene.add_child(customer)
	customer.global_position = enter_marker.global_position
	customer.set_markers({
		"order": order_marker,
		"wait": wait_marker,
		"pickup": pickup_marker,
		"exit": exit_marker
	})
	customer.serve_counter = serve_counter
	return customer
