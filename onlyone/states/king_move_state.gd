extends EnemyMoveState
class_name KingMoveState

@export var farAttackRange:float

func classStuff(_delta:float)->void:
	if see.canSee:
		if (see.target.global_position-holder.global_position).length() >= farAttackRange:
			emit_signal("transitioned",self,attack1.name)
