class_name Customer
extends CharacterBody2D

@export var speed := 50

@onready var state_machine: StateMachine = %StateMachine

signal order_taken
signal drink_ready
signal drink_picked
signal target_reached(marker_name)

var order: Recipe = null
var player_in_range:bool = false
var markers = {}
var current_target
var path = []
var serve_counter: ServeCounter= null

func _physics_process(delta):
	if current_target:
		var direction = (current_target.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		if global_position.distance_to(current_target.global_position) < 10:
			velocity = Vector2.ZERO
			emit_signal("target_reached")
			print("Reached spot")
			current_target = null

func set_markers(marker_dict: Dictionary):
	markers = marker_dict

func go_to(marker_name: String):
	if markers.has(marker_name):
		current_target = markers[marker_name]
		print("Going to marker:", marker_name)
	else:
		push_warning("❌ Unknown marker: %s" % marker_name)
		
"""
func _on_player_zone_body_entered(body: Node3D) -> void:
	if body is Player:
		player_in_range = true
		body.current_customer= self

func _on_player_zone_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_range = false
		body.current_customer = null
