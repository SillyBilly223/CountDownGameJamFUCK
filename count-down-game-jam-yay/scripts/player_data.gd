class_name PlayerData

extends Node

@export var _inventory : InventoryDisplay
@export var _dialogue_manager : DialougeManager
@export var _laptop_manager : LaptopManager
@export var _lock_manager : LockManager

@export var _use_uv_light : Button
@export var _use_spirit_box : Button

@export var _timer : Timer
@export var _timer_label : Label
@export var _scene_loader : SceneLoader

@export var _darkness_panel : Panel

@export var walking_sounds : Array[AudioStream]
@export var chase_song : AudioStream

var _current_room : RoomManager

var _set_time : int = 8 * 60
var time_left : int = _set_time

var _initilized : bool = false
var _input_lock : bool = false

var library_index : int = 0
var library_made_wrong_turn : int = 0

var hallway_count : int = 6
var hallway_chase : bool = false

# audio player
var Audio : GlobalAudioPlayer

func _get_audio() -> GlobalAudioPlayer:
	if !Audio:
		Audio = GlobalAudioPlayer.new()
	return Audio

var Music : GlobalMusicPlayer

func _get_music() -> GlobalMusicPlayer:
	if !Music:
		Music = GlobalMusicPlayer.new()
	return Music

var Ambiance : GlobalAmbiancePlayer

func _get_ambiance() -> GlobalAmbiancePlayer:
	if !Ambiance:
		Ambiance = GlobalAmbiancePlayer.new()
	return Ambiance

func play_walking_sound():
	Audio.volume_db = linear_to_db(0.2)
	Audio._play_sound(walking_sounds.pick_random())

func play_fuck():
	Ambiance.volume_db = linear_to_db(0.4)
	Ambiance.stream = chase_song
	Ambiance.play(0)

# process

func update_timer_label():
	var minutes := int(time_left) / 60
	var seconds := int(time_left) % 60
	
	$CanvasLayer/Label.text = "%02d:%02d" % [minutes, seconds]

func _on_timer_timeout() -> void:
	time_left -= 1
	if time_left <= 0:
		_input_lock = true
		Player._scene_loader.load_scene("res://rooms/special/lose_room.tscn")
		_reset_values()
		return
	
	var minutes := int(time_left) / 60
	var seconds := int(time_left) % 60
	
	$CanvasLayer/Label.text = "%02d:%02d" % [minutes, seconds]

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") and !_input_lock:
		_inventory.set_panel(!_inventory.is_visible_in_tree())

# INVENTORY STUFF

var inventory_display : Node2D

var inv_items : Array[Item]
var inv_evidence : Array[Item]

var selected_item : Item

func add_item(item : Item):
	if item.is_evidence: inv_evidence.append(item)
	else: inv_items.append(item)
	_inventory.update_inventory()
	if item.itemID == "uv_light":
		_use_uv_light.visible = true
	if item.itemID == "spirit_box":
		_use_spirit_box.visible = true

func consume_item(item_id : String):
	var index = inv_items.find_custom(is_item.bind(item_id))
	if index == -1: return false
	inv_items.remove_at(index)
	return true

func has_item(item_id : String):
	return inv_items.find_custom(is_item.bind(item_id)) != -1

func is_item(item : Item, item_id : String):
	return item_id == item.itemID

func select_item(item : Item):
	selected_item = item

func update_inventory():
	pass

#game values

const DEFAULT_GAME_VALUES := {
	game_value_id.BATHROOM_LOCKED: true,
	game_value_id.CAPTIVE_LOCKED: true,
	game_value_id.LOVE_LETTER_FOUND: false,
	game_value_id.SPIRIT_BOX_FOUND: false,
	game_value_id.KITCHECN_LETTERS_FOUND: false,
	game_value_id.GENERATOR_OFF: true,
	game_value_id.CORRECT_PASSWORD: false,
	game_value_id.LIBRARY_FIRST_TIME: false,
	game_value_id.FINISHED_LIBRARY: false,
	game_value_id.BATHROOM_ENTERED: false,
	game_value_id.NECKLEC_FOUND: false,
	game_value_id.SIGIL_1: false,
	game_value_id.SIGIL_2: false,
	game_value_id.SIGIL_3: false,
}

var game_values : Dictionary = DEFAULT_GAME_VALUES.duplicate(true)

enum game_value_id {
	BATHROOM_LOCKED,
	CAPTIVE_LOCKED,
	LOVE_LETTER_FOUND,
	SPIRIT_BOX_FOUND,
	KITCHECN_LETTERS_FOUND,
	GENERATOR_OFF,
	CORRECT_PASSWORD,
	LIBRARY_FIRST_TIME,
	FINISHED_LIBRARY,
	BATHROOM_ENTERED,
	NECKLEC_FOUND,
	SIGIL_1,
	SIGIL_2,
	SIGIL_3,
}

## remember to check if null result.
func _get_game_value(id : game_value_id) -> Variant:
	return game_values.get(id)

func _set_game_value(id : game_value_id, value : Variant) -> void:
	game_values.set(id, value)

#item use

func _on_uv_light_button_pressed() -> void:
	_current_room._use_item_in_room("uv_light")

func _on_spirit_box_button_pressed() -> void:
	_current_room._use_item_in_room("spirit_box")

func _reset_values() -> void:
	# Reset timer
	time_left = _set_time
	
	# Reset input
	_initilized = false
	_input_lock = false
	
	
	hallway_count = 8
	hallway_chase = false
	
	# Reset inventory
	inv_items.clear()
	inv_evidence.clear()
	selected_item = null
	
	# Reset game flags
	game_values = DEFAULT_GAME_VALUES.duplicate(true)
	
	# Reset library progress
	library_index = 0
	library_made_wrong_turn = 0
	_darkness_panel.visible = false
	
	# Reset UI
	if _inventory:
		_inventory.update_inventory()
	
	if _use_uv_light:
		_use_uv_light.visible = false
	
	if _use_spirit_box:
		_use_spirit_box.visible = false
	
	# Reset timer display
	if _timer_label:
		_timer_label.text = str(_set_time)
