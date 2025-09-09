class_name ItemGrid
extends GridContainer

@export var slot_scene:PackedScene

func display(item:Item):
	for child in get_children():
		child.queue_free()
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.display(item)
