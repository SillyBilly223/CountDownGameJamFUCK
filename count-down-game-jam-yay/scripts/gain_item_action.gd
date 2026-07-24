class_name ItemGain

extends GenericButton

@export var item : Item

func _ready() -> void:
	super._ready()

func _perform_action() -> void:
	Player.add_item(item)
	queue_free()
