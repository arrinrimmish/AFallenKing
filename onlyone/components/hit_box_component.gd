extends CharacterBody2D
class_name HitBoxComponent

@export var holder:CharacterBody2D
@export var healthComponent:HealthComponent
@export var knockbackComponent:KnockBackComponent
@export var iframeTimer:Timer
@export var invulnerable:bool
@export var makeInv:bool = false

func hit(attack:Attack)->void:
	if holder.is_in_group(attack.target) and !invulnerable:
		if attack.damage >0 and makeInv:
			invulnerable = true
			iframeTimer.start()
		if healthComponent:
			healthComponent.hit(attack)
		else:
			holder.death()
		if knockbackComponent:
			knockbackComponent.hit(attack)
