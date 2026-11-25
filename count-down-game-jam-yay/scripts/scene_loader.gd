class_name SceneLoader

extends Node

signal progress_changed(progress)
signal load_finished

const LOADING_SCREEN: PackedScene = preload("uid://bnudh8dd650le")
var loaded_resource: PackedScene
var scene_path: String
var progress: Array = []
var use_sub_threads: bool = true

func _ready() -> void:
	set_process(false)

func load_scene(_scene_path: String) -> void:
	scene_path = _scene_path
	var new_load_screen = LOADING_SCREEN.instantiate()
	print(new_load_screen == null)
	add_child(new_load_screen)
	progress_changed.connect(new_load_screen._on_progress_changed)
	load_finished.connect(new_load_screen._on_load_finished)
	
	await new_load_screen.loading_screen_ready
	print("await new_load_screen.loading_screen_ready")
	start_load()

func start_load() -> void:
	print("start_load")
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)

func _process(delta: float) -> void:
	print("process")
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	progress_changed.emit(progress[0])
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			print("failed")
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			print("THREAD_LOAD_LOADED")
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			get_tree().change_scene_to_packed(loaded_resource)
			load_finished.emit()
