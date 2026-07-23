class_name ConsumeTimeAction

extends Label

@export var cost : int
@export var default_text : String = " second cost"

@export var additional_labels : Array[Label]

func _ready() -> void:
	text = str(cost) + default_text
	
	if additional_labels:
		for label in additional_labels:
			label.text = text

func _perform() -> void:
	Player._consume_time(cost)
