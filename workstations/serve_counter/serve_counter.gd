extends Node2D
class_name ServeCounter

var counter_item: Node2D = null
var player: Node2D = null

func _process(delta):
	if player != null:
		if Input.is_action_just_released("interact"):
			var held = player.inventory.get_item()
			if held != null and counter_item == null:
				put_item()

func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null

func put_item():
	counter_item = player.inventory.get_item()
	player.inventory.remove_item()
	Global.reparent_item(counter_item, self, Vector2.ZERO)
	print("served ", counter_item, " on counter")
