extends Node2D

@export var base_item: Ingredient
@export var hold_time := 1.5

var held_item = Item
var player_in_range = false
var is_holding = false
var holding_time := 0.0

func _process(delta: float) -> void:
	if player_in_range == true && held_item is Cup && held_item.base == null:
		if Input.is_action_pressed("interact"):
			holding_time +=delta
			print(holding_time)
			if holding_time >= hold_time:
				held_item.add_base(base_item)
				holding_time = 0.0
				print("pour complete")
				print(held_item.get_content())
		elif Input.is_action_just_released("interact") && holding_time <= hold_time:
			holding_time = 0.0
			print("E released. time reset: ",holding_time)

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_in_range = true
	if body.inventory._content != null:
		held_item = body.inventory.get_item()
		print(held_item.get_content())
		print("hold E to fill the cup")
	else:
		print("yea ur not holding anything")

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
