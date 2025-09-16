class_name Customer
extends CharacterBody2D

@export var speed := 50
@export var drink_options = ["Latte", "Tea", "Smoothie"]
@onready var state_machine: StateMachine = %StateMachine
@onready var wait_area = get_tree().get_first_node_in_group("WaitArea")
@onready var wait_timer: Timer = %WaitTimer


var order: String = ""
var player_in_range:bool = false
var target_pos :Vector2
var dir: Vector2 

func _ready() -> void:
	print("Customer ready:")
	order = ""

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
