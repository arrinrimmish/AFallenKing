extends Node2D

func _ready() -> void:
	var moveTween:Tween = create_tween()
	moveTween.tween_property($RichTextLabel,"position",Vector2(-263,-1300),90)
	moveTween.tween_callback(PauseMenu.changeScene.bind("res://scenes+scripts/locations/main_scene.tscn"))
