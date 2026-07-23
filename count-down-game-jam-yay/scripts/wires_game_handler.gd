class_name WiresGameHandler

extends Node2D

@export var timer : float
@export var manager : ActionPopup
@export var label : Label

@export var win_img : Node2D
@export var lose_img : Node2D

@export var open_sound : AudioStream
@export var close_sound : AudioStream

@export var width : float

@export var starts : Array[PuzzleHoverable]
@export var ends : Array[PuzzleHoverable]

@export var colors : Array[Color]

var start_indexes : Array[int]
var end_indexes : Array[int]
var completed : Array[bool]

var time : int
var timeup : bool

func _is_done() -> bool:
	if completed:
		for i in completed.size():
			if !completed[i]:
				return false
		return true
	return false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player._get_audio()._play_sound(open_sound)
	
	time = timer
	timeup = false
	
	win_img.visible = false
	lose_img.visible = false
	
	start_indexes = []
	end_indexes = []
	completed = []
	
	for i in colors.size():
		start_indexes.append(i)
		end_indexes.append(i)
		completed.append(false)
	
	end_indexes.shuffle()
	
	for i in colors.size():
		starts[i].icon.modulate = colors[i]
		starts[i].label.text = str(i)
		ends[i].icon.modulate = colors[end_indexes[i]]
		ends[i].label.text = str(end_indexes[i])

var current_wire : int
var pressed : bool

func _input(event : InputEvent) -> void:
	if timeup:
		return
	if event is InputEventMouseButton and event.button_index == 1:
		if event.pressed:
			pressed = true
			for i in starts.size():
				if starts[i].mouse_over:
					current_wire = i
					break
		else:
			if !completed[current_wire]:
				for i in ends.size():
					if ends[i].mouse_over and i == current_wire:
						completed[i] = true
						_draw_line(-1, colors[current_wire], starts[current_wire].global_position, ends[i].global_position)
			pressed = false
			current_wire = -1
			if _is_done():
				timeup = true
				manager._set_return_value(true)
				time = 2.0
				win_img.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= delta
	
	if time <= 0:
		if timeup:
			Player._get_audio()._play_sound(close_sound)
			manager._on_finished()
		else:
			time = 2.0
			timeup = true
			manager._set_return_value(false)
			lose_img.visible = true
		return
	
	var temp = snapped(max(0.0, time), 1)
	label.text = "0"
	if temp < 10:
		label.text += str(temp)
	else:
		label.text = str(temp)
	
	if pressed and current_wire >= 0 and current_wire < colors.size() and !completed[current_wire]:
		_draw_line(delta, colors[current_wire], starts[current_wire].global_position, to_global(get_local_mouse_position()))


func _draw_line(time: float, color : Color, orig : Vector2, pos : Vector2) -> void:
	var line = Line2D.new()
	add_child(line)
	line.global_position = orig
	line.add_point(Vector2.ZERO)
	line.add_point(pos - line.global_position)
	line.width = width
	line.modulate = color
	line.z_index = 1
	
	if time < 0:
		return
	await get_tree().create_timer(time * 2).timeout
	line.queue_free()
