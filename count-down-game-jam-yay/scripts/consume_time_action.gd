class_name ConsumeTimeAction

extends Label

@export var cost : int
@export var default_text : String = " second cost"

func _ready() -> void:
	text = str(cost) + default_text

func _perform() -> void:
	Player._consume_time(cost)
