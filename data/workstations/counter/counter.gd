extends Node2D

var counter_item: Node2D = null
var player: Node2D = null

func _process(delta):
	if player != null:
		if Input.is_action_just_released("interact"):
			if player.inventory.get_item() != null and counter_item == null:
				put_item()
			elif player.inventory.get_item() == null and counter_item != null:
				take_item()
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	print("player in counter zone")
	player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("player left counter zone")
	player = null

func put_item():
	counter_item = player.inventory.get_item()
	player.inventory.remove_item()
	Global.reparent_item(counter_item, self, Vector2.ZERO)
	print("placed ", counter_item, " on counter")

func take_item():
	player.on_item_picked_up(counter_item)
	counter_item = null
	print("picked up item")
