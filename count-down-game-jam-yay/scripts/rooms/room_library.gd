class_name RoomLibrary

extends RoomManager

@export var paths : Array[path_types]
@export var spirit_responce : Array[path_types]
@export var led_spot : Array[path_types]
@export var max_paths : int = 4

enum path_types {LEFT,MIDDLE,RIGHT,NONE}

const path_spirit_text : Array[String] = ["LeefFt","MidDDlle","RigHHht"]
const path_led_text : Array[String] = ["twords your right","infront of you","twords your right"]

func _ready() -> void:
	super._ready()
	
	if Player.library_made_wrong_turn:
		Player._dialogue_manager.start_dialouge(["I think i made a wrong turn..."] as Array[String])
		Player.library_made_wrong_turn = false

func _use_item_in_room(item_id : String):
	if item_id == "spirit_box": 
		if spirit_responce[Player.library_index] == path_types.NONE:
			Player._dialogue_manager.start_dialouge(["*static*"] as Array[String])
			return
		var responce = "*" + path_spirit_text[spirit_responce[Player.library_index]] + "*"
		Player._dialogue_manager.start_dialouge([responce] as Array[String])
		return
	else:
		if led_spot[Player.library_index] == path_types.NONE:
			Player._dialogue_manager.start_dialouge(["*You cant make out anything.*"] as Array[String])
			return
		var responce = "*You faintly see scratches " + path_led_text[led_spot[Player.library_index]] + "*"
		Player._dialogue_manager.start_dialouge([responce] as Array[String])
		return

func _go_down_path(path_type : path_types):
	print("path_type: ", path_type, " corrent: ", Player.library_index, " please??: ", path_type == paths[Player.library_index])
	if path_type == paths[Player.library_index] and Player._get_game_value(Player.game_value_id.SPIRIT_BOX_FOUND): 
		Player.library_index += 1
	else:
		Player.library_index = 0
		if path_type != path_types.NONE:
			Player.library_made_wrong_turn = true
	print("path_index ", Player.library_index)
