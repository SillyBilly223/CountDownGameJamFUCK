extends RoomManager

@export var USELESS_arrows : Array[Area2D] 
@export var epicbaconarrow : Area2D

func _ready() -> void:
	super._ready()
	if Player.hallway_chase:
		for arrow in USELESS_arrows:
			arrow.visible = false
		epicbaconarrow.visible = true
	if Player._initilized: return
	Player._get_music().play()
	Player._timer_label.set_deferred("visible", true)
	if Player._timer.is_stopped():
		Player._timer.start()
	Player.update_timer_label()
	Player._initilized = true

func _use_item_in_room(item_id : String):
	if item_id == "spirit_box":
		Player._dialogue_manager.start_dialouge(["*The spirit box gives off a faint buzz.*"] as Array[String])
		return
	Player._dialogue_manager.start_dialouge(["Nothing happened."] as Array[String])
