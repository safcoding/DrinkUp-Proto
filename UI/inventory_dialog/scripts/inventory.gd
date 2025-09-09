class_name Inventory

var _content:Item = null

func  add_item(item:Item):
	if _content == null:
		_content = item
	else:
		print(_content," in inventory")
	
func remove_item():
	_content = null
	
func get_item()  -> Item:
	return _content
