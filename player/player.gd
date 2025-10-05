extends CharacterBody2D
class_name Player

@onready var hand: Node2D = %Hand

var speed = 100
var player_state
var current_customer:Customer = null
var inventory:Inventory = Inventory.new()

var nearby_blender = null

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	else:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	
	play_anim(direction)

	handle_interaction()

func play_anim(dir):
	if player_state =="idle":
		$AnimatedSprite2D.play("idle")
	elif player_state == "walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_n")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk_s")
		if dir.x == 1:
			$AnimatedSprite2D.play("walk_e")
		if dir.x == -1:
			$AnimatedSprite2D.play("walk_w")
			
		if dir.x > 0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("walk_se")
		if dir.x < -0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("walk_nw")
		if dir.x > 0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("walk_ne")
		if dir.x < -0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("walk_sw")

func player():
	pass

func _unhandled_input(event: InputEvent):
	if current_customer != null and Input.is_action_just_released("interact"):
		accept_order()
		
func on_item_picked_up(item:Node2D):
	if inventory.get_item() == null:
		inventory.add_item(item)
		Global.reparent_item(item,hand,Vector2(0,-16))
	else:
		print("hands full")
		
func accept_order():
	print ("Customer wants ", current_customer.order)
	current_customer.accept_order()

func handle_interaction():
	if nearby_blender != null and Input.is_action_just_pressed("interact"):
		var item = inventory.get_item()

		if item == null:
			return

		if item.name == "Lemon":
			if nearby_blender.add_lemon(item):
				inventory.remove_item()

		if item.name == "Cup":
			var juice = nearby_blender.take_juice()
			if juice != null:
				print("I have a cup of Lemon Juice!")
				item.queue_free()
				inventory.remove_item()

# This function is called BY the Blender when it detects the player
func set_nearby_blender(blender_node):
	nearby_blender = blender_node

func _on_blender_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_blender_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
