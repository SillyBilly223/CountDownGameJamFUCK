class_name DialougeManager

extends Panel

@export var in_process : bool = false
@export var characters_per_second : float = 45.0

var current_dialogue : DialougeScript = null
var dialogue_lines : Array[String] = []

var dialouge_index : int

var full_text : String = ""
var visible_characters : float = 0.0
var typing : bool = false

func _ready() -> void:
	set_process(false)
	set_process_input(false)

func _process(delta: float) -> void:
	if !typing:
		return
	
	visible_characters += characters_per_second * delta
	$RichTextLabel.visible_characters = int(visible_characters)
	
	if $RichTextLabel.visible_characters >= full_text.length():
		$RichTextLabel.visible_characters = -1
		typing = false
		set_process(false)


func _input(event: InputEvent) -> void:
	if !(event is InputEventMouseButton):
		return
	
	if event.button_index != MOUSE_BUTTON_LEFT or !event.pressed:
		return
	
	if typing:
		$RichTextLabel.visible_characters = -1
		typing = false
		set_process(false)
		return
	
	dialouge_index += 1
	
	if dialouge_index >= dialogue_lines.size():
		in_process = false
		visible = false
		set_process(false)
		set_process_input(false)
		Player._input_lock = false
		
		if current_dialogue:
			current_dialogue._on_dialouge_finished()
		
		return
	
	_start_current_line()

func start_dialouge(dialouge) -> void:
	if dialouge == null:
		return
	
	current_dialogue = null
	dialogue_lines.clear()
	
	if dialouge is DialougeScript:
		current_dialogue = dialouge
		dialogue_lines = dialouge.dialouge
	
	elif dialouge is Array:
		dialogue_lines = dialouge
	
	else:
		push_error("Invalid dialogue type passed to start_dialouge()")
		return
	
	in_process = true
	dialouge_index = 0
	
	visible = true
	set_process_input(true)
	Player._input_lock = true
	
	_start_current_line()


func _start_current_line() -> void:
	full_text = dialogue_lines[dialouge_index]
	
	$RichTextLabel.text = full_text
	$RichTextLabel.visible_characters = 0
	
	visible_characters = 0.0
	typing = true
	
	set_process(true)
