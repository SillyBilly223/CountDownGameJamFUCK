class_name Player

extends Node

static var realtime : bool

static func _set_realtime(value : bool) -> void:
	realtime = value

static var time : int = 1000

static func _set_time(amt : int) -> void:
	time = amt

static func _consume_time(amt : int) -> void:
	_set_time(maxi(0, _get_time() - amt))

static func _get_time() -> int:
	return time



# INVENTORY STUFF

static var inv_size : int

static var inv_id : Array[int]
static var inv_names : Array[String]
static var inv_icon : Array[Texture2D]

static var inventory_display : Node2D

static func _set_inv_item(index : int, item : String, icon : Texture2D, id : int = 0) -> void:
	if !inv_id:
		_reset_inv()
	if index >= inv_size:
		return
	
	inv_id[index] = id
	inv_names[index] = item
	inv_icon[index] = icon
	_update_inv(index)

static func _del_item(index : int) -> void:
	if !inv_id or index >= inv_size:
		return
	
	inv_id[index] = -1
	inv_names[index] = ""
	inv_icon[index] = null
	_update_inv(index)

static func _get_item(index : int) -> Dictionary:
	if !inv_id or index >= inv_size or !inv_names[index]:
		return {"id":-1, "item":"", "icon":null}
	
	var item = {"id": inv_id[index], "item":inv_names[index], "icon":inv_icon[index]}
	return item

static func _pop_item(index : int) -> Dictionary:
	var item = _get_item(index)
	_del_item(index)
	return item

static func _reset_inv() -> void:
	inv_id = []
	inv_id.resize(inv_size)
	inv_id.fill(-1)
	
	inv_names = []
	inv_names.resize(inv_size)
	
	inv_icon = []
	inv_icon.resize(inv_size)
	
	_update_inv(-1)

static func _update_inv(index : int = -1) -> void:
	if !inventory_display:
		return
	
	pass

#game values

static var game_values : Dictionary

## remember to check if null result.
static func _get_game_value(id : String) -> Variant:
	if !game_values:
		_reset_values()
	
	return game_values.get(id)

static func _set_game_value(id : String, value : Variant) -> void:
	if !game_values:
		_reset_values()
	
	game_values.set(id, value)

static func _reset_values() -> void:
	game_values = {}
