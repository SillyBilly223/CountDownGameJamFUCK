class_name DialougeMoveScene

extends DialougeScript

@export_file_path("*tscn") var Scene

func _on_dialouge_finished():
	Player._scene_loader.load_scene(Scene)
