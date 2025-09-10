class_name Inventory

var _content:Node = null

func  add_item(item:Node):
	if _content == null:
		print("added ",item)
		_content = item
	else:
		print(_content," in inventory")
	
func remove_item():
	print("removed ", _content)
	_content = null
	
func get_item()  -> Node:
	return _content
