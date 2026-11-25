class_name LockManager

extends Control

@export var lock_code: int = 0

var digit_1 := 0
var digit_2 := 0
var digit_3 := 0
var digit_4 := 0

func _ready() -> void:
	visible = false
	set_process_input(false)

func show_lock() -> void:
	digit_1 = 0
	digit_2 = 0
	digit_3 = 0
	digit_4 = 0
	
	$Digit_1.text = "0"
	$Digit_2.text = "0"
	$Digit_3.text = "0"
	$Digit_4.text = "0"
	
	visible = true
	set_process_input(true)
	Player._input_lock = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		close_lock()

func close_lock() -> void:
	visible = false
	set_process_input(false)
	Player._input_lock = false

func complete_combination() -> void:
	Player._set_game_value(Player.game_value_id.CAPTIVE_LOCKED, false)
	close_lock()

func check_digits() -> void:
	var combination := digit_1 * 1000 + digit_2 * 100 + digit_3 * 10 + digit_4

	if combination == lock_code:
		complete_combination()

func _on_digit_1_pressed() -> void:
	digit_1 = (digit_1 + 1) % 10
	$Digit_1.text = str(digit_1)
	check_digits()

func _on_digit_2_pressed() -> void:
	digit_2 = (digit_2 + 1) % 10
	$Digit_2.text = str(digit_2)
	check_digits()

func _on_digit_3_pressed() -> void:
	digit_3 = (digit_3 + 1) % 10
	$Digit_3.text = str(digit_3)
	check_digits()

func _on_digit_4_pressed() -> void:
	digit_4 = (digit_4 + 1) % 10
	$Digit_4.text = str(digit_4)
	check_digits()
