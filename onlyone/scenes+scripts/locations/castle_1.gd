extends Node2D

@export var path:String = "res://scenes+scripts/locations/castle_1.tscn"
@export var bossFightWall:StaticBody2D
@export var knight:KnightBoss
@export var starter:Marker2D
@export var center:Marker2D
@export var start:Vector2 = Vector2(0,0)

var startEnemyAmount:int = 0

func _on_enter_fight_body_entered(body: Node2D) -> void:
	if body is Player:
		if knight:
			var moveTween:Tween = create_tween()
			moveTween.set_parallel()
			moveTween.tween_property(bossFightWall.get_child(0),"position",Vector2.ZERO,0.25)
			moveTween.tween_property(bossFightWall.get_child(1),"position",Vector2.ZERO,0.25)
			moveTween.tween_property(bossFightWall.get_child(2),"position",Vector2.ZERO,0.25)
			moveTween.tween_property(bossFightWall.get_child(3),"position",Vector2.ZERO,0.25)
	elif body.is_in_group("enemy"):
		
		startEnemyAmount += 1


func _on_enter_fight_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		startEnemyAmount -= 1
		if knight:
			if startEnemyAmount == 0:
				knight.arenaCenter.global_position = center.global_position
				knight.global_position = starter.global_position
		else:
			var moveTween:Tween = create_tween()
			moveTween.tween_property(bossFightWall.get_child(0),"position",Vector2(0,-196),0.25)
			moveTween.tween_property(bossFightWall.get_child(1),"position",Vector2(-245,0),0.25)
			moveTween.tween_property(bossFightWall.get_child(2),"position",Vector2(170,0),0.25)
			moveTween.tween_property(bossFightWall.get_child(3),"position",Vector2(0,183),0.25)
			


func _on_next_scene_body_entered(body: Node2D) -> void:
	if body is Player:
		PauseMenu.changeScene("res://scenes+scripts/locations/castle_2.tscn")
