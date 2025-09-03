extends Node2D

var state  = "no apples"
var player_in_area = false

func _ready():
	if state == "no apples":
		$grow_timer.start()

func _process(delta):
	if state == "no apples":
		$AnimatedSprite2D.play("no_apple")
	if state == "apples":
		$AnimatedSprite2D.play("apples")
		if player_in_area:
			if Input.is_action_just_pressed("interact"):
				print("pressed e")
				state = "no apples"
				print("growth timer started")
				$grow_timer.start()


func _on_pick_area_body_entered(body):
	if body.has_method("player"):
		print("player entered tree zone")
		player_in_area = true

func _on_pick_area_body_exited(body):
	if body.has_method("player"):
		print("player exited tree zone")
		player_in_area = false


func _on_grow_timer_timeout():
	if state == "no apples":
		state = "apples"
