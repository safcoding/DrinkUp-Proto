class_name Customer
extends CharacterBody2D

@export var speed := 50

@onready var state_machine: StateMachine = %StateMachine
@onready var wait_area = get_tree().get_first_node_in_group("WaitArea")
@onready var wait_timer: Timer = %WaitTimer
@onready var astar_controller := get_tree().get_first_node_in_group("AStarController")

var path: PackedVector2Array = []
var path_index := 0
var order: Recipe = null
var player_in_range:bool = false
	
func _physics_process(delta):
	if path.size() == 0 or path_index >= path.size():
		return
	var target_point = path[path_index]
	var direction = (target_point - global_position).normnalized()
	velocity = direction *  speed
	move_and_slide()
	
	if global_position.distance_to(target_point) < 5.0:
		path_index += 1
		
func set_target(target_pos: Vector2):
	if  astar_controller == null:
		astar_controller = get_tree().get_first_node_in_group("AstarController")

func accept_order():
	if state_machine.state is OrderState:
		state_machine.state.accept_order()

func _on_player_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_range = true
		body.current_customer= self

func _on_player_zone_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_range = false
		body.current_customer = null
