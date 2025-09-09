extends Node2D

var counter_item:Item = null
var player: Node2D = null

func _process(delta):
	if player != null:
		if Input.is_action_just_released("interact"):
			if player.inventory.get_item() != null &&  counter_item == null:
				put_item()
			elif player.inventory.get_item() == null && counter_item != null:
				take_item()
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	print("player in counter zone")
	player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("player left counter zone")
	player = null

func take_item():
	player.inventory.add_item(counter_item)
	print(counter_item," added to inventory")
	counter_item = null
	
func put_item():
	counter_item = player.inventory.get_item()
	print(counter_item," on counter")
	player.inventory.remove_item()
	print("Player inv: ", player.inventory.get_item())
