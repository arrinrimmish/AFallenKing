extends Node2D

@export var bossBlocks:StaticBody2D
@export var king:KingBoss
@export var path:String = "res://scenes+scripts/locations/castle_3.tscn"
@export var start:Vector2 = Vector2(-3140,-1620)

func _ready() -> void:
	king.end_game.connect(endGame)

func _on_enter_fight_body_entered(body: Node2D) -> void:
	if body is Player:
		var moveTween:Tween = create_tween()
		moveTween.tween_property(bossBlocks.get_child(1),"position",Vector2(0,0),0.25)

func endGame()->void:
	PauseMenu.changeScene("res://scenes+scripts/locations/end_game.tscn")
