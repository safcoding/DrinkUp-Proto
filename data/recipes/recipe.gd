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
var total_price: int

func calculate_price() -> int:
	var price = 0
	for key in ingredients.keys():
		var ingredient = ingredients[key]
		if ingredient != null:
			total_price += ingredient.price
	return total_price
