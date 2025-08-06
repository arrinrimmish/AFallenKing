extends State
class_name KnightManageState

@export var healthComp:HealthComponent
@export var centerState:CenterMoveState
@export var summonState:SummonState
@export var chargeState:ChargeState
@export var slowMoveState:EnemyMoveState

var stage1Finished:bool = false
var stage2Finished:bool = false

var counter:int = 3


func enter()->void:
	if !stage1Finished and healthComp.health <= round(2*healthComp.maxHealth/3):
		stage1Finished = true
		emit_signal("transitioned",self,centerState.name)
		summonState.startSummonAmount = 4
		counter = 4
		return
	elif !stage2Finished and healthComp.health <= round(healthComp.maxHealth/3):
		stage2Finished = true
		emit_signal("transitioned",self,centerState.name)
		summonState.startSummonAmount = 8
		counter = 2
		return
	elif counter <0 and stage1Finished:
		if stage2Finished:
			counter = 2
			emit_signal("transitioned",self,chargeState.name)
			return
		else:
			counter = 4
			emit_signal("transitioned",self,chargeState.name)
			return
	else:
		counter -= 1
		emit_signal("transitioned",self,slowMoveState.name)
		return
