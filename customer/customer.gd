class_name Customer
extends CharacterBody2D

signal target_reached

@export var speed := 50
@onready var state_machine: StateMachine = %StateMachine
@onready var wait_area = get_tree().get_first_node_in_group("WaitArea")
@onready var wait_timer: Timer = %WaitTimer
@onready var navigation_agent_2d: NavigationAgent2D = %NavigationAgent2D


var order: Recipe = null
var player_in_range:bool = false
var target_location :Vector2 = Vector2.ZERO
var did_arrive: bool
	
func _physics_process(delta):
	
	var move_direction = position.direction_to(navigation_agent_2d.get_next_path_position())
	velocity = move_direction * speed
	navigation_agent_2d.set_velocity(velocity)
	
	if not _arrived_at_location():
		move_and_slide()
	elif not did_arrive:
		did_arrive = true
		emit_signal("target_reached")

func _on_player_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_range = true
		body.current_customer= self


func _on_player_zone_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_range = false
		body.current_customer = null
		
func accept_order():
	if state_machine.state is OrderState:
		state_machine.state.accept_order()
		
func set_target_location(target:Vector2):
	did_arrive = false
	target_location = target
	navigation_agent_2d.set_target_location(target)

func _arrived_at_location() -> bool:
	return navigation_agent_2d.is_navigation_finished()
