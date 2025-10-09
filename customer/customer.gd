class_name Customer
extends CharacterBody2D

@export var speed := 50

@onready var state_machine: StateMachine = %StateMachine
@onready var wait_area = get_tree().get_first_node_in_group("WaitArea")
@onready var wait_timer: Timer = %WaitTimer

var astar_controller: AStarController = null
var path = []
var current_index := 0
var order: Recipe = null
var player_in_range:bool = false
	
func _ready():
	astar_controller = get_tree().get_first_node_in_group("AStarController")

func _physics_process(delta):
	if path.is_empty():
		return
	var target_pos = path[current_index]
	var direction = (target_pos - global_position).normalized()
	global_position += direction * speed * delta
	
	if global_position.distance_to(target_pos) < 5.0:
		current_index += 1
		if current_index >= path.size():
			path.clear()

func go_to(from:Marker2D, to:Marker2D):
	path = astar_controller.get_customer_path(from.global_position,to.global_position)
	current_index = 0
	
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
