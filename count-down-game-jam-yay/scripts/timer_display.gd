class_name TimerDisplay

# set img transparent a little

extends Node2D

@export var minutes : Label
@export var seconds : Label
@export var lock_to_top_center : bool

var tick : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_time()
	tick = 1.0
	if lock_to_top_center:
		self.global_position = Vector2(576.0, 72.0)
		self.scale = Vector2(0.2, 0.2)

func _set_time() -> void:
	var m_text = "0"
	var mins : int = mini(99, floor(Player._get_time() / 60))
	if mins < 10:
		m_text += str(mins)
	else:
		m_text = str(mins)
	minutes.text = m_text
	
	var s_text = "0"
	var secs : int = Player._get_time() % 60
	if secs < 10:
		s_text += str(secs)
	else:
		s_text = str(secs)
	seconds.text = s_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_set_time()
	
	if Player.realtime:
		tick -= delta
		if tick <= 0:
			tick = 1.0
			Player._consume_time(1)
