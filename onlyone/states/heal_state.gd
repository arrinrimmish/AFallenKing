extends State
class_name HealState

@export var healthComp:HealthComponent
@export var nextState:State
@export var previousState:State

func enter()->void:
	if healthComp.health<healthComp.maxHealth:
		var attack:Attack = Attack.new()
		attack.damage = -1
		healthComp.hit(attack)
		emit_signal("transitioned",self,nextState.name)
	else:
		emit_signal("transitioned",self,previousState.name)
