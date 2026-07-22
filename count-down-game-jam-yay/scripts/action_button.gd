class_name GenericButton

extends Area2D

@export var action : ConsumeTimeAction
@export var cost_popup : Node2D
@export var shape : Sprite2D

@export var default_color : Color
@export var hovered_color : Color

@export var lock_label_pos : bool
@export var label_y_mod : float

var mouse_over : bool

func _ready() -> void:
	mouse_over = false
	if shape: shape.modulate = default_color
	if cost_popup: cost_popup.visible = false
	
	if lock_label_pos and cost_popup:
		cost_popup.global_rotation = 0.0
		cost_popup.global_position = Vector2(self.global_position.x, self.global_position.y + label_y_mod)

func _mouse_enter() -> void:
	mouse_over = true
	if cost_popup: cost_popup.visible = true
	if shape: shape.modulate = hovered_color

func _mouse_exit() -> void:
	mouse_over = false
	if cost_popup: cost_popup.visible = false
	if shape: shape.modulate = default_color

func _input(event : InputEvent) -> void:
	if !visible:
		return
	
	if mouse_over and event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		_perform_action()

func _perform_action() -> void:
	action._perform()
