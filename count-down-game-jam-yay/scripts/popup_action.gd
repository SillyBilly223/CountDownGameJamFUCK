class_name PopupAction

extends ConsumeTimeAction

@export var popup_base : PackedScene
@export var handler : BasePopupResultHandler

@export var hide_on_finish : bool
@export var img_hide : Sprite2D

@export var animate_on_finish : bool
@export var img_anim : AnimatedSprite2D
@export var default_anim : String
@export var closed_anim : String

func _ready() -> void:
	super._ready()
	if hide_on_finish and img_hide:
		img_hide.visible = true
	if animate_on_finish and img_anim:
		img_anim.play(default_anim)

var popup : ActionPopup

func _perform() -> void:
	super._perform()
	_run_popup()

func _run_popup() -> void:
	popup = popup_base.instantiate()
	popup.action = self
	get_tree().root.add_child(popup)

func _on_complete(args : Variant) -> void:
	popup.queue_free()
	handler._handle_result(args)
	
	if hide_on_finish and img_hide:
		img_hide.visible = false
	if animate_on_finish and img_anim:
		img_anim.play(closed_anim)
