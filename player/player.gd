extends CharacterBody3D
class_name Player

@onready var hand: Node2D = %Hand

@export_group("Movement")
@export var move_speed := 8.0
@export var  acceleration := 20.0

signal order_taken

var speed = 100
var player_state
var current_customer = null
var inventory:Inventory = Inventory.new()

func _ready():
	print ("Money: ",Global.player_money)
	
func _physics_process(delta):
	var raw_input := Input.get_vector("move_left","move_right","move_up","move_down")
	var move_direction := Vector3(raw_input.x, 0, raw_input.y)
	move_direction = move_direction.normalized()
	velocity= velocity.move_toward(move_direction * move_speed,  acceleration * delta)
	move_and_slide()
"""
func player():
	pass

func _unhandled_input(event: InputEvent):
	if current_customer != null and Input.is_action_just_released("interact"):
		accept_order()

func on_item_picked_up(item:Node3D):
	if inventory.get_item() == null:
		inventory.add_item(item)
		Global.reparent_item(item,hand,Vector2(0,-16))
	else:
		print("hands full")

func accept_order():
	print ("Customer wants ", current_customer.order)
	current_customer.emit_signal("order_taken")
"""
