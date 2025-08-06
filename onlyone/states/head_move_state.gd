extends MoveState
class_name dragonHeadMoveState

@export var follow:Node2D
@export var point:Marker2D
@export var sight:SightComponent
@export var rotateSpeed:float

func get_direction()->Vector2:
	if sight.canSee:
		return (point.global_position-holder.global_position)
	return Vector2.ZERO

func classStuff(delta:float)->void:
	if sight.canSee:
		follow.rotation_degrees += sign(rad_to_deg(follow.get_angle_to(sight.target.global_position)))*rotateSpeed*delta
