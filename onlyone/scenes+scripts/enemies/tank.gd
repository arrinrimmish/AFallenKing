extends CharacterBody2D
class_name TankEnemy

@export var healthComp:HealthComponent
@export var cracks:Node2D

func death()->void:
	for i in range(4):
		var corpse:CharacterBody2D = ResourceLoader.load("res://scenes+scripts/enemies/corpse.tscn").instantiate()
		get_tree().current_scene.add_child.call_deferred(corpse)
		corpse.global_position = global_position + Vector2(randi_range(-15,15),randi_range(-15,15))
		corpse.rotation_degrees = $square.rotation_degrees
		queue_free()

func hit(_attack:Attack)->void:
	if healthComp.health != 0:
		cracks.get_child(int(2-healthComp.health)).visible = true
