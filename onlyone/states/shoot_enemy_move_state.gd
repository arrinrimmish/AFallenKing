extends EnemyMoveState
class_name ShootEnemyMoveState

@export var orb1:Polygon2D
@export var orb2:Polygon2D



func classStuff(delta:float)->void:
	
	orb1.rotation_degrees += 30*delta
	orb2.rotation_degrees -= 30*delta
