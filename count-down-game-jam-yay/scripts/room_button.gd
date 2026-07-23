class_name RoomChangeButton

extends GenericButton

@export var sprite : AnimatedSprite2D
@export var Scene : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	action.Scene = Scene
	if sprite:
		sprite.play("idle")
		sprite.modulate = default_color

func _mouse_enter() -> void:
	if Player._get_game_value("busy"):
		return
	super._mouse_enter()
	if sprite:
		sprite.play("active")
		sprite.modulate = hovered_color

func _mouse_exit() -> void:
	super._mouse_exit()
	if sprite:
		sprite.play("idle")
		sprite.modulate = default_color
