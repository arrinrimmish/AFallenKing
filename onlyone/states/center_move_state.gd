extends MoveState
class_name CenterMoveState


@export var nextState:State
@export var arenaCenter:Marker2D

func _ready() -> void:
	arenaCenter.global_position = holder.global_position

func get_direction()->Vector2:
		var directionTo:Vector2 = arenaCenter.global_position- holder.global_position
		if directionTo.length()<=8:
			emit_signal("transitioned",self,nextState.name)
		return directionTo.normalized()

func exit()->void:
	holder.velocity = Vector2.ZERO
