class_name RoomManager

extends Node

@export var sprite : Sprite2D

func _ready() -> void:
	Player._current_room = self

func _use_item_in_room(item_id : String):
	Player._dialogue_manager.start_dialouge(["Nothing happened."] as Array[String])
	pass
