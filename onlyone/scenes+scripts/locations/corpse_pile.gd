extends Node2D

@export var path:String = "res://scenes+scripts/locations/corpse_pile.tscn"
@export var start:Vector2 = Vector2(0,0)

func _on_enter_palace_body_entered(body: Node2D) -> void:
	if body is Player and PauseMenu.player:
		PauseMenu.inCutscene = true
		get_tree().paused = true
		PauseMenu.player.questionBox.visible = true
		PauseMenu.player.questioner = self

func yes()->void:
	PauseMenu.inCutscene = false
	get_tree().paused = false
	PauseMenu.player.questionBox.visible = false
	PauseMenu.player.position = Vector2(0,85)
	#PauseMenu.player.position = Vector2(0,85)
	PauseMenu.changeScene("res://scenes+scripts/locations/castle_1.tscn")

func no()->void:
	PauseMenu.inCutscene = false
	get_tree().paused = false
	PauseMenu.player.questionBox.visible = false
