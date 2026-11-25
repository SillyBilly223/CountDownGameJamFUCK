extends RoomManager

@export var evilbackground : Sprite2D

@export var evilsprite : Texture2D
@export var normalsprite : Texture2D

@export var forward_arrow : Area2D

@export_multiline() var evilgirldialouge : Array[String]

func _ready() -> void:
	super._ready()
	if Player.hallway_chase:
		forward_arrow.visible = false
	if Player.hallway_count <= 0 and !Player.hallway_chase:
		forward_arrow.visible = false
		Player.hallway_chase = true
		evilbackground.visible = true
		Player._dialogue_manager.start_dialouge(evilgirldialouge)
		Player.play_fuck()
		Player.time_left = 0.80 * 60
		Player.hallway_count = 28
