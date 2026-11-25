class_name LaptopManager

extends Node

@export var password_screen : TextureRect
@export var password_email : TextureRect

@export_multiline var email_draft : String
@export_multiline var email_dad : String

const CORRECT_PASSWORD : String = "isabell"

func _ready() -> void:
	self.set_process_input(false)

func show_laptop():
	$Laptop_email/ItemList.select(0)
	if Player._get_game_value(Player.game_value_id.CORRECT_PASSWORD):
		password_screen.set_deferred("visible", false)
		password_email.set_deferred("visible", true)
	else:
		password_screen.set_deferred("visible", true)
		password_email.set_deferred("visible", false)
	self.set_deferred("visible", true)
	self.set_process_input(true)
	Player._input_lock = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		self.set_deferred("visible", false)
		self.set_process_input(false)
		Player._input_lock = false

func _on_line_edit_text_submitted(new_text: String) -> void:
	new_text = new_text.to_lower()
	if new_text == CORRECT_PASSWORD:
		Player._set_game_value(Player.game_value_id.CORRECT_PASSWORD, true)
		password_screen.set_deferred("visible", false)
		password_email.set_deferred("visible", true)
	$Laptop_password/LineEdit.text = "INCORRECT PASSWORD"

func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if index == 0:
		$Laptop_email/EmailShow.text = email_draft
	else:
		$Laptop_email/EmailShow.text = email_dad
