class_name BasePopup

extends Node2D

var return_value : Variant
var active : bool

func _is_running() -> bool:
	return active

func _set_return_value(value : Variant) -> void:
	return_value = value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active = true
	Player._set_game_value("busy", true)

func _on_finished() -> Variant:
	active = false
	Player._set_game_value("busy", false)
	return return_value

func _get_output() -> Variant:
	if _is_running():
		return null
	return return_value
