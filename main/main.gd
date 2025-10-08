extends Node2D

@onready var customer = $Customer
@onready var order_marker: Marker2D = %orderMarker
@onready var wait_marker: Marker2D = %waitMarker
@onready var astar_controller: AStarController = %AstarController

func _ready():
	customer.astar_controller = astar_controller
	print("✅ AstarController assigned to customer:", customer.astar_controller)
	customer.go_to(order_marker, wait_marker)
	print("passed ",order_marker," | ", wait_marker, " to customer")
