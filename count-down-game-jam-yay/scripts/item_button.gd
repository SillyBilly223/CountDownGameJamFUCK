class_name ItemGainButton

extends GenericButton

@export var item_index : int
@export var item : String
@export var icon : Texture2D
@export var itemID : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	action.item_index = item_index
	action.item = item
	action.icon = icon
	action.itemID = itemID
