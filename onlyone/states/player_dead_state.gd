extends State
class_name PlayerDeadState

@export var holder:CharacterBody2D
@export var healthComp:HealthComponent

func enter()->void:
	var current:Node = get_tree().current_scene.get_child(1)
	if current:
		print(current.name)
		var fadeTween:Tween = create_tween()
		fadeTween.tween_property(current,"modulate",Color.BLACK,0.25)
		fadeTween.tween_property(holder,"position",current.start,0)
		fadeTween.tween_property(healthComp,"health",healthComp.maxHealth,0)
		fadeTween.tween_callback(PauseMenu.changeScene.bind(current.path))
