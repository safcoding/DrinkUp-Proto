extends Node2D

@onready var customer = $Customer
@onready var order_marker: Marker2D = %orderMarker
@onready var wait_marker: Marker2D = %waitMarker
@onready var astar_controller: AStarController = %AstarController
@onready var exit_marker: Marker2D = %exitMarker

func _ready():
	customer.astar_controller = astar_controller
	customer.go_to(order_marker, exit_marker)
