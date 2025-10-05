extends Resource
class_name Recipe

@export var id: String
@export var name: String
@export var ingredients: Dictionary = {
	"base": "",
	"flavour": "",
	"topping": ""
}
@export var active: bool = false
