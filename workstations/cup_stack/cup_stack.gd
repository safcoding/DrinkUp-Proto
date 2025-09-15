extends Node2D

var player:Node = null
var count:int = 3
@export var cup:PackedScene

func _process(delta):
	if player != null:
		if Input.is_action_just_released("interact"):
			if player.inventory.get_item() == null and count > 0:
				take_item()

func take_item():
	var new_item = cup.instantiate()
	player.on_item_picked_up(new_item)
	print("picked up cup")
	count -= 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("player in cup stack zone")
	player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("player left cup stack zone")
	player = null
