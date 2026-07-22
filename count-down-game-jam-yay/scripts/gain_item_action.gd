class_name ItemGain

extends ConsumeTimeAction


@export var item_index : int
@export var item : String
@export var icon : Texture2D
@export var itemID : int


func _perform() -> void:
	super._perform()
	_set_item()

func _set_item() -> void:
	Player._set_inv_item(item_index, item, icon, itemID)
