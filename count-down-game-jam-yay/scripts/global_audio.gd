class_name GlobalAudioPlayer

extends AudioStreamPlayer

func _ready() -> void:
	Player.Audio = self

func _play_sound(sound : AudioStream) -> void:
	stop()
	stream = sound
	play()
