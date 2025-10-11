extends State
class_name CustomerState

const ORDER = "Order"
const WAIT = "Wait"
const PICKUP = "Pickup"
const LEAVE = "Leave"

var customer:Customer

func _ready() -> void:
	await owner.ready
	customer = owner as Customer
	assert(customer != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
