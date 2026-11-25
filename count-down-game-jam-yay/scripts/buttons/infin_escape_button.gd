class_name InfinEscapeButton

extends GenericButton

@export var sprite : AnimatedSprite2D

@export_file_path("*.tscn") var scene_path : String
@export_file_path("*.tscn") var scene_loop : String

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
	if Player.hallway_chase:
		Player.hallway_count -= 1
	
	if Player.hallway_count > 0 and Player.hallway_chase:
		Player._scene_loader.load_scene(scene_loop)
	else:
		Player._scene_loader.load_scene(scene_path)
	Player.play_walking_sound()
