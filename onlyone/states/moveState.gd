extends State
class_name MoveState

@export var holder:CharacterBody2D
@export var speed:float#how fast you speed up
@export var drag:float#how fast you slow down
@export var maxSpeed:float
@export var character:Node2D
@export var attack1:State
@export var heal1:State
@export var runDirection:int = 1

var speedModifier:float = 0

func update(delta:float)->void:
	character.rotation_degrees += 10*delta
	if holder.velocity != Vector2.ZERO:
		character.rotation_degrees += 120*delta
	if checkAttack():
		emit_signal("transitioned",self,attack1.name)
	if checkHeal():
		emit_signal("transitioned",self,heal1.name)
	classStuff(delta)
	

func physicsUpdate(delta:float)->void:
	var direction:Vector2 = get_direction()
	if holder.velocity.length() > drag*delta:
		holder.velocity -= holder.velocity.normalized()*drag*delta
	else:
		holder.velocity = Vector2.ZERO
	if holder.velocity.length() <= maxSpeed+speedModifier:
		holder.velocity += direction*(drag+speed)*delta*runDirection
	holder.move_and_slide()

func get_direction()->Vector2:
	return(Vector2.ZERO)

func checkAttack()->bool:
	return(false)

func checkHeal()->bool:
	return false

func classStuff(_delta:float)->void:
	pass
