class_name ActionLockedDoor

extends ButtonAction

@export var locked_door_dialogue : DialougeScript
@export var locked_door_value : Player.game_value_id

func _perform_action() -> Variant:
	if Player._get_game_value(locked_door_value):
		Player._dialogue_manager.start_dialouge(locked_door_dialogue)
		return false
	return true
