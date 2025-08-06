extends State
class_name TeleportState

@export var stateMachine:StateMachine
@export var holder:CharacterBody2D
@export var teleport:Node2D
@export var point:Marker2D
@export var collision1:CollisionShape2D
@export var collision2:CollisionShape2D
@export var teleportTimer:Timer
@export var texture:Node2D
@export var sight:SightComponent
@export var teleportRange:float
@export var nextState:State
@export var particles:CPUParticles2D
@export var staff:Node2D

func _ready() -> void:
	teleportTimer.timeout.connect(appear)

func enter()->void:
	print(point.global_position)
	collision1.set_deferred("disabled",true)
	collision2.set_deferred("disabled",true)
	if (holder.global_position-sight.target.global_position).length() < teleportRange:
		texture.visible = false
		particles.emitting = true
		teleportTimer.start()
	else:
		emit_signal("transitioned",self,nextState.name)

func appear()->void:
	var previousPoint:Vector2 = point.position
	while (point.global_position-sight.target.global_position).length() <= teleportRange+30 or point.position == previousPoint:
		teleport.rotation_degrees = randi_range(0,360)
		point.position.x = randi_range(0,190)
	holder.global_position = point.global_position
	texture.visible = true
	particles.emitting = true
	emit_signal("transitioned",self,nextState.name)

func exit()->void:
	collision1.set_deferred("disabled",false)
	collision2.set_deferred("disabled",false)
	staff.look_at(sight.target.global_position)
