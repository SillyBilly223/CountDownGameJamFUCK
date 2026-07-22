class_name GenericButton

extends Area2D

@export var action : ConsumeTimeAction
@export var cost_popup : Node2D
@export var shape : Sprite2D

@export var default_color : Color
@export var hovered_color : Color

var mouse_over : bool

func _ready() -> void:
	mouse_over = false
	if shape: shape.modulate = default_color
	if cost_popup: cost_popup.visible = false

func _mouse_enter() -> void:
	mouse_over = true
	if cost_popup: cost_popup.visible = true
	if shape: shape.modulate = hovered_color

func _mouse_exit() -> void:
	mouse_over = false
	if cost_popup: cost_popup.visible = false
	if shape: shape.modulate = default_color

func _input(event : InputEvent) -> void:
	if mouse_over and event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		_perform_action()

func _perform_action() -> void:
	action._perform()
