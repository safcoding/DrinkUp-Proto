class_name Ingredient
extends Node2D

@export var item_name: String
@export var sweetness: int = 0
@export var bitterness: int = 0
@export var creaminess: int = 0
@export var freshness: int = 0
@export var price: int = 0

func get_stats() -> Dictionary:
	return {
		"sweetness": sweetness,
		"bitterness": bitterness,
		"creaminess": creaminess,
		"freshness": freshness,
	}
