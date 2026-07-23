class_name ActionPopup

extends BasePopup

var action : PopupAction

func _on_finished() -> Variant:
	active = false
	action._on_complete(return_value)
	return return_value
