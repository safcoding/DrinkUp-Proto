extends Node2D

class_name CustomerSpawner

@onready var customer = preload("res://customer/customer.tscn")
var parent

func _on_timer_timeout() -> void:
	var customer_instance = customer.instantiate()
	get_parent().add_child(customer_instance)
