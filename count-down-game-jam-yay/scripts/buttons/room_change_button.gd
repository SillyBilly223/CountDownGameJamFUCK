class_name RoomChangeButton

extends GenericButton

@export var sprite : AnimatedSprite2D
@export_file_path("*.tscn") var Scene : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	if sprite:
		sprite.play("idle")
		sprite.modulate = default_color

func _mouse_enter() -> void:
	super._mouse_enter()
	if sprite:
		sprite.play("active")
		sprite.modulate = hovered_color

func _mouse_exit() -> void:
	super._mouse_exit()
	if sprite:
		sprite.play("idle")
		sprite.modulate = default_color

func _perform_action() -> void:
	if action != null and !action._perform_action():
		return
	Player._scene_loader.load_scene(Scene)
	Player.play_walking_sound()
