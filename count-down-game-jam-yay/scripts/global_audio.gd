class_name GlobalAudioPlayer

extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player.Audio = self


func _play_sound(sound : AudioStream) -> void:
	stop()
	stream = sound
	play()
