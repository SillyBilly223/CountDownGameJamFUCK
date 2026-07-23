class_name BasicHoverable

extends Area2D

var mouse_over : bool

func _ready() -> void:
	mouse_over = false

func _mouse_enter() -> void:
	mouse_over = true

func _mouse_exit() -> void:
	mouse_over = false
