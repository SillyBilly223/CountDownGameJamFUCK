class_name ActionInteractDialouge

extends ButtonAction

@export var dialouge : Array[String]
@export var return_value : bool

func _perform_action() -> Variant:
	Player._dialogue_manager.start_dialouge(dialouge)
	return return_value
