class_name DoorButton

extends GenericButton

@export var sprite : Sprite2D
@export var hover_sprite : Texture
@export_file_path("*.tscn") var Scene : String

var normal_sprite : Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	normal_sprite = sprite.texture

func _mouse_enter() -> void:
	super._mouse_enter()
	sprite.texture = hover_sprite

func _mouse_exit() -> void:
	super._mouse_exit()
	sprite.texture = normal_sprite

func _perform_action() -> void:
	if action != null and !action._perform_action():
		return
	Player._scene_loader.load_scene(Scene)
	Player.play_walking_sound()
