class_name InventoryDisplay

extends Panel

@export var _items_select : ItemList
@export var _evidence_select : ItemList
@export var _evidence_image : TextureRect

@export var _inventory_text : RichTextLabel

func update_inventory():
	_items_select.clear()
	_evidence_select.clear()
	
	for item in Player.inv_items:
		_items_select.add_icon_item(item.icon, item == Player.selected_item)
	for item in Player.inv_evidence:
		_evidence_select.add_item(item.item_name)

func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	_evidence_image.texture = null
	_inventory_text.text = ""
	
	if Player.inv_items.size() <= index: 
		_inventory_text.text = "item error"
		return
	var item = Player.inv_items[index]
	_inventory_text.text = item.item_description
	Player.selected_item = item

func _on_item_list_item_clicked_evidence(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	_evidence_image.texture = null
	_inventory_text.text = ""
	
	if Player.inv_evidence.size() <= index: 
		_inventory_text.text = "evidence error"
		return
	var evidence = Player.inv_evidence[index]
	if evidence.evidence_image != null:
		_inventory_text.text = ""
		_evidence_image.texture = evidence.evidence_image
	else:
		_inventory_text.text = evidence.item_description

func set_panel(enabled : bool):
	self.set_deferred("visible", enabled)
