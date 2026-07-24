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

var inventory_display : Node2D

var inv_items : Array[Item]

func add_item(item : Item):
	inv_items.append(item)
	update_inventory()

func consume_item(item_id : String):
	var index = inv_items.find_custom(is_item.bind(item_id))
	if index == -1: return false
	inv_items.remove_at(index)
	return true

func has_item(item_id : String):
	return inv_items.find_custom(is_item.bind(item_id)) != -1

func is_item(item : Item, item_id : String):
	return item_id == item.itemID

func update_inventory():
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
