class_name TimerDisplay

extends Node2D

@export var label : Label
@export var lock_to_top_center : bool

var tick : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tick = 1.0
	if lock_to_top_center:
		self.global_position = Vector2(576.0, 25.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(Player._get_time()) + " seconds"
	
	if Player.realtime:
		tick -= delta
		if tick <= 0:
			tick = 1.0
			Player._consume_time(1)
