extends Node2D
@export var music:AudioStreamPlayer

func _ready() -> void:
	print("Eric, make sure you turn the audio back on please")

func _process(_delta: float) -> void:
	if PauseMenu.player:
		if PauseMenu.player.fightingBoss:
			var quietTween:Tween = create_tween()
			quietTween.tween_property(music,"volume_db",-80,0.25)
		else:
			var loudTween:Tween = create_tween()
			loudTween.tween_property(music,"volume_db",0,0.25)
