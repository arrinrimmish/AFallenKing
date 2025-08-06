extends CharacterBody2D
class_name Dragon

@export var hitBox:HitBoxComponent
@export var moveState:DragonMoveState

func death()->void:
	var corpse:CharacterBody2D = ResourceLoader.load("res://scenes+scripts/enemies/corpse.tscn").instantiate()
	get_tree().current_scene.add_child.call_deferred(corpse)
	corpse.global_position = global_position
	corpse.rotation_degrees = $square.rotation_degrees
	queue_free()
