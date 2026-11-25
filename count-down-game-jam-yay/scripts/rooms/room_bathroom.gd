extends SigilRoom

@export_multiline var enter_dialouge : Array[String]

func _ready() -> void:
	super._ready()
	if !Player._get_game_value(Player.game_value_id.BATHROOM_ENTERED):
		Player._dialogue_manager.start_dialouge(enter_dialouge)
		Player._set_game_value(Player.game_value_id.BATHROOM_ENTERED, true)
