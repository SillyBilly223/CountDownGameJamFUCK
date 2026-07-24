class_name GameValueResultHandler

extends BasePopupResultHandler

@export var gameval : String

func _handle_result(value : Variant) -> void:
	Player._set_game_value(gameval, value)
