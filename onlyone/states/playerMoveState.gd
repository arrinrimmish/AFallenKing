extends MoveState
class_name PlayerMoveState

@export var pickCorpseSight:SightComponent
@export var line:Line2D

var corpses:Array = []

func enter()->void:
	corpses = []

func exit()->void:
	corpses = []
	if holder.name =="player":
		line.points = PackedVector2Array([Vector2.ZERO])

func classStuff(_delta:float)->void:
	if true:
		return
	speedModifier = -30*corpses.size()
	if holder.dead:
		emit_signal("transitioned",self,"playerDeadState")
	if pickCorpseSight.canSee:
		if !pickCorpseSight.target in corpses and corpses.size() < 2:
			corpses += [pickCorpseSight.target]
			pickCorpseSight.canSee = false
			pickCorpseSight.target = null
			print(corpses.size())
			line.points += PackedVector2Array([Vector2.ZERO,Vector2.ZERO])
	var number:int = 1
	for i:CharacterBody2D in corpses:
		line.points[2*number-1] = i.global_position-holder.global_position
		line.points[2*number] = Vector2.ZERO
		number+=1
		var distance:Vector2 = (holder.global_position-i.global_position)
		if distance.length() >= 60:
			i.global_position += distance.normalized()*(distance.length()-60)
			i.move_and_slide()
	if Input.is_action_just_pressed("drop"):
		corpses = []
		line.points = PackedVector2Array([Vector2.ZERO])


func get_direction()->Vector2:
	return(Input.get_vector("left","right","up","down"))

func checkAttack()->bool:
	return(Input.is_action_just_pressed("attack"))

func checkHeal()->bool:
	if holder.name == "player" and Input.is_action_just_pressed("heal"):
		return true
	return false
