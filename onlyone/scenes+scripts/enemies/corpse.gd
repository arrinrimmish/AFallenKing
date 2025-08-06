extends CharacterBody2D
class_name Corpse

func start() -> void:
	print(global_position)
	$CPUParticles2D.emitting = true

func _on_timer_timeout() -> void:
	print(position,"      ",global_position)
	print(position+get_parent().position)
	$CollisionShape2D.disabled = false
