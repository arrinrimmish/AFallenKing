extends State
class_name MageManageState

@export var healthComp:HealthComponent
@export var enterShootState:TeleportState
@export var dragonState:MageDragonState
@export var circleState:State
@export var fireColumnState:State

var dragon:bool = false
var stage1:bool = false
var stage2:bool = false

func enter()->void:
	if !dragon and healthComp.health <= (healthComp.maxHealth/2):
		dragon = true
		emit_signal("transitioned",self,dragonState.name)
		return
	elif !stage1 and  healthComp.health <= (healthComp.maxHealth/3*2):
		stage1 = true
		emit_signal("transitioned",self,circleState.name)
		return
	elif !stage2 and  healthComp.health <= (healthComp.maxHealth/3):
		stage2 = true
		emit_signal("transitioned",self,circleState.name)
		return
	else:
		emit_signal("transitioned",self,enterShootState.name)
