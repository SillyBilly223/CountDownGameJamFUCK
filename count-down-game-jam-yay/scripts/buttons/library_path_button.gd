class_name LibraryPathButton

extends GenericButton

@export var sprite : AnimatedSprite2D

@export_file_path("*.tscn") var Scene_path : String
@export_file_path("*.tscn") var Scene_clock : String
@export var path_type : RoomLibrary.path_types 

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
	var room = (Player._current_room as RoomLibrary)
	room._go_down_path(path_type)
	if Player.library_index >= room.max_paths:
		Player._scene_loader.load_scene(Scene_clock)
	else:
		Player._scene_loader.load_scene(Scene_path)
	Player.play_walking_sound()
