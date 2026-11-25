class_name SigilRoom

extends RoomManager

@export var sigil_sprite : Sprite2D

@export var sigil_digit : String
@export var sigil_key : Player.game_value_id

func _use_item_in_room(item_id : String):
	if item_id == "spirit_box" and Player._get_game_value(Player.game_value_id.BATHROOM_ENTERED):
		if Player._get_game_value(sigil_key):
			var responce = "*A faint voice whispers the digit " + sigil_digit + "*"
			Player._dialogue_manager.start_dialouge([responce] as Array[String])
		else:
			Player._dialogue_manager.start_dialouge(["*The spirit box gives off a faint buzz.*"] as Array[String])
		return
	elif !Player._get_game_value(sigil_key) and Player._get_game_value(Player.game_value_id.BATHROOM_ENTERED):
		Player._dialogue_manager.start_dialouge(["*A sigil is revealed.*"] as Array[String])
		Player._set_game_value(sigil_key, true)
