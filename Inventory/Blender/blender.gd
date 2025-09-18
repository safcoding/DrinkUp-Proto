extends Area2D
class_name Blender

signal blending_finished(juice_type)

enum State { EMPTY, HAS_LEMON, BLEND, FINISHED }
var current_state = State.EMPTY

var blend_progress = 0.0
const BLEND_TIME = 3.0

var lemon_node: Node2D = null

func _ready():
	add_to_group("blenders")

func _process(delta):
	if Input.is_action_pressed("blend") and current_state == State.HAS_LEMON:
		current_state = State.BLEND
		print("Starting to blend...")

	if current_state == State.BLEND:
		blend_progress += delta
		if blend_progress >= BLEND_TIME:
			finish_blending()

# Connect THIS node's body_entered signal to THIS function
func _on_body_entered(body):
	if body.is_in_group("players"):
		body.set_nearby_blender(self)
		print("Blender detected player")

# Connect THIS node's body_exited signal to THIS function
func _on_body_exited(body):
	if body.is_in_group("players"):
		body.set_nearby_blender(null)
		print("Player left blender")

func add_lemon(item: Node2D):
	if current_state == State.EMPTY:
		lemon_node = item
		item.hide()
		current_state = State.HAS_LEMON
		return true
	return false

func finish_blending():
	current_state = State.FINISHED
	blend_progress = 0.0
	if lemon_node != null:
		lemon_node.queue_free()
		lemon_node = null
	blending_finished.emit("LemonJuice")
	print("Blending finished!")

func take_juice():
	if current_state == State.FINISHED:
		current_state = State.EMPTY
		return "LemonJuice"
	return null
