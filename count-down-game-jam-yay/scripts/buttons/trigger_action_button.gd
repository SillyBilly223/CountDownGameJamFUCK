class_name TriggerActionButton

extends GenericButton

@export var item_sprite : Sprite2D
@export var hover_sprite : Texture2D

var normal_sprite : Texture2D

func _ready() -> void:
	super._ready()
	normal_sprite = item_sprite.texture

func _mouse_enter() -> void:
	super._mouse_enter()
	item_sprite.texture = hover_sprite

func _mouse_exit() -> void:
	super._mouse_exit()
	item_sprite.texture = normal_sprite

func _perform_action() -> void:
	action._perform_action()
