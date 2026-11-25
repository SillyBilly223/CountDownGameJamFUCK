extends RoomManager

@export_multiline var enter_dialouge : Array[String]
@export var bathroom_key : Item

func _ready() -> void:
	super._ready()
	if !Player._get_game_value(Player.game_value_id.FINISHED_LIBRARY):
		Player._dialogue_manager.start_dialouge(enter_dialouge)
		Player.add_item(bathroom_key)
		Player._set_game_value(Player.game_value_id.BATHROOM_LOCKED, false)
		Player._set_game_value(Player.game_value_id.FINISHED_LIBRARY, true)
