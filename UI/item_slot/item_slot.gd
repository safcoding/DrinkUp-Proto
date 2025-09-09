extends PanelContainer
@onready var texture_rect: TextureRect = %TextureRect

func display(item:Item):
	texture_rect.texture = item.icon
	texture_rect.expand = true
	texture_rect.stretch_mode  = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture_rect.custom_minimum_size = Vector2(64,64)
