class_name ActionLaptop

extends ButtonAction

func _perform_action() -> Variant:
	Player._laptop_manager.show_laptop()
	return
