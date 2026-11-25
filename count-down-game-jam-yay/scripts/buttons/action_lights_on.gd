class_name ActionLightsOn

extends ButtonAction

@export var dialouge : Array[String]
@export var return_value : bool

@export var generator_sound : AudioStream

func _perform_action() -> Variant:
	Player._dialogue_manager.start_dialouge(dialouge)
	Player._darkness_panel.visible = false
	Player.Audio.volume_db = linear_to_db(0.2)
	Player.Audio._play_sound(generator_sound)
	return return_value
