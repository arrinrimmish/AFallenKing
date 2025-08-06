extends State
class_name KingManageState

@export var holder:CharacterBody2D
@export var healthComp:HealthComponent
@export var moveState:KingMoveState
@export var fastMoveState:KingMoveState
@export var spiritState:KingSpiritState
@export var rapidFireState:KingRapidFireState
@export var rapidFireParticles:CPUParticles2D
@export var dragonState:KingDragonState
@export var dragonMoveState:EnemyMoveState
@export var stateMachine:StateMachine

var stage1:bool = false
var stage2:bool = false
var stage3:bool = false

var rapidFireAmount:int = 0
var rapidFiring:bool = false

var dragoning:bool = false

var dragonDeaths:int = 0

func enter()->void:
	if rapidFiring:
		print(rapidFireAmount)
		if rapidFireAmount > 0:
			emit_signal("transitioned",self,rapidFireState.name)
			return
		else:
			rapidFiring = false
			rapidFireParticles.emitting = false
	if !stage1 and healthComp.health <= 15:
		stage1 = true
		rapidFiring = true
		rapidFireAmount = 15
		rapidFireParticles.emitting = true
		emit_signal("transitioned",self,rapidFireState.name)
		return
	elif !stage2 and healthComp.health <= 10:
		stage2 = true
		dragoning = true
		emit_signal("transitioned",self,dragonState.name)
	elif !stage3 and healthComp.health <= 5:
		stage3 = true
		rapidFiring = true
		rapidFireAmount = 20
		rapidFireParticles.emitting = true
		emit_signal("transitioned",self,rapidFireState.name)
	else:
		if dragoning:
			emit_signal("transitioned",self,dragonMoveState.name)
			return
		elif stage3:
			emit_signal("transitioned",self,fastMoveState.name)
			return
		else:
			emit_signal("transitioned",self,moveState.name)
			return

func dragonDie()->void:
	dragonDeaths += 1
	if dragonDeaths == 2:
		dragoning = false
		if stateMachine.currentState is EnemyMoveState:
			emit_signal("transitioned",stateMachine.currentState,name)
