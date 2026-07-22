class_name SceneChanger

extends Node


@export var Scene : PackedScene



func _change_scene() -> void:
	if Scene:
		get_tree().change_scene_to_packed(Scene)
