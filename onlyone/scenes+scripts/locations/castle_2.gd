extends Node2D

@export var dragon:DragonHead
@export var dragonBlocks:StaticBody2D
@export var bossFightBlocks:StaticBody2D
@export var mageBoss:MageBoss
@export var startingPoint:Marker2D
@export var enterFightCollision:CollisionShape2D
@export var path:String = "res://scenes+scripts/locations/castle_2.tscn"
@export var start:Vector2 = Vector2(3150,-1639)

var enemyCount:int = 0
var playerIn:bool = false
var dragonBlocksMoved:bool = false
var mageBlocksMoved:bool = false

func _on_enter_fight_body_entered(body: Node2D) -> void:
	if body is Player:
		var moveTween:Tween = create_tween()
		moveTween.tween_property(bossFightBlocks.get_child(0),"position",Vector2.ZERO,0.25)
		playerIn = true
	elif body.is_in_group("enemy"):
		enemyCount += 1


func _on_enter_fight_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemyCount -= 1
		if playerIn and enemyCount == 0:
			enterFightCollision.disabled = true
			mageBoss.teleport.global_position = startingPoint.global_position
			mageBoss.global_position = startingPoint.global_position
		


func _on_dragon_fight_body_entered(body: Node2D) -> void:
	if body is Player:
		var moveTween:Tween = create_tween()
		moveTween.tween_property(dragonBlocks.get_child(0),"position",Vector2.ZERO,0.25)

func _process(_delta: float) -> void:
	if !dragon and !dragonBlocksMoved:
		dragonBlocksMoved = true
		var moveTween:Tween = create_tween()
		moveTween.tween_property(dragonBlocks.get_child(1),"position",Vector2(0,-430),0.25)
	if !mageBoss and !mageBlocksMoved:
		mageBlocksMoved = true
		var moveMageTween:Tween = create_tween()
		moveMageTween.tween_property(bossFightBlocks.get_child(1),"position",Vector2(225,0),0.25)
	
		


func _on_next_scene_body_entered(body: Node2D) -> void:
	if body is Player:
		PauseMenu.changeScene("res://scenes+scripts/locations/castle_3.tscn")
