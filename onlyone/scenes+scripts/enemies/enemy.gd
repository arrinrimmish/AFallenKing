extends CharacterBody2D
class_name SlashEnemy



func death()->void:
	var corpse:Corpse = ResourceLoader.load("res://scenes+scripts/enemies/corpse.tscn").instantiate()
	get_tree().current_scene.get_child(1).add_child.call_deferred(corpse)
	corpse.global_position = global_position
	corpse.rotation_degrees = $square.rotation_degrees
	corpse.start()
	queue_free()
