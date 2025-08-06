extends State
class_name EnterState

@export var sight:SightComponent
@export var nextState:State

func update(_delta:float)->void:
	if sight.canSee:
		emit_signal("transitioned",self,nextState.name)
