class_name SceneChanger

extends ConsumeTimeAction


@export var Scene : PackedScene


func _perform() -> void:
	super._perform()
	_change_scene()

func _change_scene() -> void:
	if Scene:
		get_tree().change_scene_to_packed(Scene)
