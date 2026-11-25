class_name ItemCollectButton

extends GenericButton

@export var item_sprite : Sprite2D
@export var hover_sprite : Texture2D

@export var collections : Array[Item]
@export var collection_picked_id : Player.game_value_id
@export var dissapear_value : bool

var normal_sprite : Texture2D

func _ready() -> void:
	super._ready()
	normal_sprite = item_sprite.texture
	self.set_deferred("visible", Player._get_game_value(collection_picked_id) != dissapear_value)

func _mouse_enter() -> void:
	super._mouse_enter()
	item_sprite.texture = hover_sprite

func _mouse_exit() -> void:
	super._mouse_exit()
	item_sprite.texture = normal_sprite

func _perform_action() -> void:
	if action != null and action._perform_action():
		return
	Player._set_game_value(collection_picked_id, !Player._get_game_value(collection_picked_id))
	print(Player._get_game_value(collection_picked_id), " ", collection_picked_id)
	if collections != null:
		for item in collections:
			Player.add_item(item)
	self.set_deferred("visible", false)
