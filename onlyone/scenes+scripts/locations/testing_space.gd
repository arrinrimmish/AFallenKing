extends Node2D


func _ready() -> void:
	var musicTween:Tween = create_tween()
	musicTween.tween_property($AudioStreamPlayer,"volume_db",-80,3)
