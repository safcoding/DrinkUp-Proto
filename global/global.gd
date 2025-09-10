extends Node

func reparent_item(item: Node2D, new_parent: Node, local_offset: Vector2 = Vector2.ZERO) -> void:
	if item == null or new_parent == null:
		return
	if item.get_parent():
		item.get_parent().remove_child(item)
	new_parent.add_child(item)
	item.position = local_offset
