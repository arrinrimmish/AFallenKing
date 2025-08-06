extends Corpse
class_name PowerCorpse

func _process(_delta: float) -> void:
	if $SightComponent.canSee:
		PauseMenu.player.healthComp.maxHealth += 1
		PauseMenu.player.healthComp.health += 1
		PauseMenu.player.updateHealthBar()
		$SightComponent.canSee = false
		$SightComponent/CollisionShape2D.disabled = true
		$square.color = Color(0.45, 1.0, 0.551)
		$constantParticles.emitting = false
		$CPUParticles2D.emitting = true
		$CollisionShape2D.disabled = false
