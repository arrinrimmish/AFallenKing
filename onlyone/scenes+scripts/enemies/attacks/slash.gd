extends Node2D
class_name Slash

func _ready() -> void:
	var slashTween:Tween = create_tween()
	slashTween.tween_property($mask,"offset",Vector2(-17,-50),0.12)
	slashTween.tween_interval(0.05)
	slashTween.tween_callback(queue_free)
