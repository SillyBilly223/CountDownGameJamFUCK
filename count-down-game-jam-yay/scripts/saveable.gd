class_name PlayerData

extends Node

var realtime : bool

func _set_realtime(value : bool) -> void:
	realtime = value

var time : int = 1000

func _set_time(amt : int) -> void:
	time = amt

func _consume_time(amt : int) -> void:
	_set_time(maxi(0, _get_time() - amt))

func _get_time() -> int:
	return time


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


# process

func _process(delta : float) -> void:
	pass


# INVENTORY STUFF

var inv_size : int

var inv_id : Array[int]
var inv_names : Array[String]
var inv_icon : Array[Texture2D]

var inventory_display : Node2D

func _set_inv_item(index : int, item : String, icon : Texture2D, id : int = 0) -> void:
	if !inv_id:
		_reset_inv()
	if index >= inv_size:
		return
	
	inv_id[index] = id
	inv_names[index] = item
	inv_icon[index] = icon
	_update_inv(index)

func _del_item(index : int) -> void:
	if !inv_id or index >= inv_size:
		return
	
	inv_id[index] = -1
	inv_names[index] = ""
	inv_icon[index] = null
	_update_inv(index)

func _get_item(index : int) -> Dictionary:
	if !inv_id or index >= inv_size or !inv_names[index]:
		return {"id":-1, "item":"", "icon":null}
	
	var item = {"id": inv_id[index], "item":inv_names[index], "icon":inv_icon[index]}
	return item

func _pop_item(index : int) -> Dictionary:
	var item = _get_item(index)
	_del_item(index)
	return item

func _reset_inv() -> void:
	inv_id = []
	inv_id.resize(inv_size)
	inv_id.fill(-1)
	
	inv_names = []
	inv_names.resize(inv_size)
	
	inv_icon = []
	inv_icon.resize(inv_size)
	
	_update_inv(-1)

func _update_inv(index : int = -1) -> void:
	if !inventory_display:
		return
	
	pass

#game values

var game_values : Dictionary

## remember to check if null result.
func _get_game_value(id : String) -> Variant:
	if !game_values:
		_reset_values()
	
	return game_values.get(id)

func _set_game_value(id : String, value : Variant) -> void:
	if !game_values:
		_reset_values()
	
	game_values.set(id, value)

func _reset_values() -> void:
	game_values = {}
