extends Node2D

@export var base_item_scene: PackedScene
@export var hold_time :float

var cup: Cup = null
var player: Node = null
var holding_time := 0.0
var is_holding := false

func _process(delta: float) -> void:
	if cup != null and cup.base == null:
		if Input.is_action_pressed("interact"):
			holding_time += delta
			print(holding_time)
			if not is_holding and holding_time >= hold_time:
				var ingredient_instance = base_item_scene.instantiate() as Ingredient
				cup.add_base(ingredient_instance)
				is_holding = true 
				holding_time = 0.0
				print("Pour complete")
				cup.get_content()
		elif Input.is_action_just_released("interact"):
			holding_time = 0.0
			is_holding = false  
			print("E released. Time reset")

func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	if body.inventory.get_item() is Cup:
		cup = body.inventory.get_item()
		print("Hold E to fill the cup")

func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null
	cup = null
	holding_time = 0.0
	is_holding = false
