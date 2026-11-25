extends RoomManager

@export var dialouge : DialougeMoveScene

func _ready() -> void:
	Player._dialogue_manager.start_dialouge(dialouge)
