extends MoveState
class_name CivMoveState

@export var see:SightComponent
@export var closeSight:SightComponent
@export var closeRadius:float
@export var stopRange:float

var lastThing:Array

func enter()->void:
	closeSight.get_child(0).shape.radius = closeRadius+randf_range(-15,15)

func get_direction()->Vector2:
	if see.canSee:
		var directionTo:Vector2 = see.target.global_position- holder.global_position
		if directionTo.length()*runDirection>=stopRange*runDirection:
			for i:CharacterBody2D in closeSight.targets:
				directionTo -= i.global_position-holder.global_position
			return directionTo.normalized()
	return Vector2.ZERO
