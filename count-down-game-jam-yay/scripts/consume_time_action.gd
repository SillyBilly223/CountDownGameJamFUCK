class_name ConsumeTimeAction

extends Node

@export var cost : int


func _perform() -> void:
	Player._consume_time(cost)
