extends MoveState
class_name EnemyMoveState

@export var see:SightComponent
@export var closeSight:SightComponent
@export var closeRadius:float
@export var attackRange:float
@export var stopRange:float
@export var tool:Node2D

func enter()->void:
	closeSight.get_child(0).shape.radius = closeRadius+randf_range(-5,5)

func checkAttack()->bool:
	if see.canSee:
		var targetPos:Vector2 = see.target.global_position
		tool.look_at(targetPos)
		return (holder.global_position-targetPos).length()*runDirection<=attackRange*runDirection #also stops function so won't move on
	return false #so now if not ^ then this

func get_direction()->Vector2:
	if see.canSee:
		var directionTo:Vector2 = see.target.global_position- holder.global_position
		if directionTo.length()*runDirection>=stopRange*runDirection:
			for i:CharacterBody2D in closeSight.targets:
				directionTo -= i.global_position-holder.global_position
			return directionTo.normalized()
	return Vector2.ZERO
