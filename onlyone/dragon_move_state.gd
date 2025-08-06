extends MoveState
class_name DragonMoveState

@export var target:Node2D
@export var sight:SightComponent

func get_direction()->Vector2:
	if (target.global_position-holder.global_position).length() <= 20:
		return Vector2.ZERO
	return (target.global_position-holder.global_position).normalized()
