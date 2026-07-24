class_name MazeMovable

extends CharacterBody2D

@export var speed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	
	velocity.x = Input.get_axis("player_a", "player_d") * speed
	velocity.y = Input.get_axis("player_w", "player_s") * speed
	
	move_and_slide()
