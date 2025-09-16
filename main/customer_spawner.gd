extends Node2D

class_name CustomerSpawner

@onready var queue_manager: QueueManager = %QueueManager
@onready var customer = preload("res://customer/customer.tscn")

func _on_timer_timeout() -> void:
	if queue_manager.queue_check() == false:
		var customer_instance = customer.instantiate()
		customer_instance.position = position
		get_parent().add_child(customer_instance)
		queue_manager.add_customer(customer_instance)
	else:
		$Timer.start
		print("Timer restarted")
