class_name ActionCombinationDoor

extends ButtonAction

func _perform_action() -> Variant:
	if Player._get_game_value(Player.game_value_id.CAPTIVE_LOCKED):
		Player._lock_manager.show_lock()
		return false
	return true
