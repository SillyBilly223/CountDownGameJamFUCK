extends RoomManager

@export var wifes_diary : Item
@export var spirit_box : Item

func _use_item_in_room(item_id : String):
	if item_id == "uv_light":
		if !Player._get_game_value(Player.game_value_id.SPIRIT_BOX_FOUND):
			Player._dialogue_manager.start_dialouge(["I think theres something glowing in the corner..."] as Array[String])
			Player._dialogue_manager.start_dialouge(["*You find the wife's diary and a spirit box.*"] as Array[String])	
			Player.add_item(wifes_diary)
			Player.add_item(spirit_box)
			Player._set_game_value(Player.game_value_id.SPIRIT_BOX_FOUND, true)
		else:
			Player._dialogue_manager.start_dialouge(["I dont see anything else."] as Array[String])
		return
	Player._dialogue_manager.start_dialouge(["Nothing happened."] as Array[String])
