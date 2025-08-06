extends State
class_name MageCircleState

@export var stateMachine:StateMachine
@export var holder:CharacterBody2D
@export var teleport:Node2D
@export var point:Marker2D
@export var teleportTimer:Timer
@export var texture:Node2D
@export var sight:SightComponent
@export var nextState:State
@export var particles:CPUParticles2D
@export var staff:Node2D
@export var orbs:Node2D
@export var circleTimer:Timer
@export var stunTimer:Timer
@export var pauseTimer:Timer
@export var character:Polygon2D

var continueShooting:bool = false

func _ready() -> void:
	pauseTimer.timeout.connect(start)
	stunTimer.timeout.connect(next)
	circleTimer.timeout.connect(shoot)
	teleportTimer.timeout.connect(appear)

func enter()->void:
	print("hello there troublemaker")
	continueShooting = false
	texture.visible = false
	particles.emitting = true
	teleportTimer.start(2)

func appear()->void:
		holder.global_position = teleport.global_position
		texture.visible = true
		particles.emitting = true
		pauseTimer.start()

func update(delta:float)->void:
	character.rotation_degrees += 40*delta
	if continueShooting:
		staff.rotation_degrees += 360*delta
		if staff.rotation_degrees >= 3600:
			continueShooting = false

func start()->void:
		continueShooting = true
		circleTimer.start()

func shoot()->void:
	for i in range(1+int(staff.rotation_degrees>+1800)):
		var blast:EnemyBlast = ResourceLoader.load("res://scenes+scripts/enemies/attacks/enemy_blast.tscn").instantiate()
		get_tree().current_scene.add_child(blast)
		blast.global_position = orbs.global_position+Vector2(randi_range(-5,5),randi_range(-5,5))
		blast.direction = (sight.target.global_position-orbs.global_position).normalized()
		blast.direction += Vector2(randf_range(-0.3,0.3),randf_range(-0.3,0.3))
		blast.look_at(sight.target.global_position)
		if continueShooting:
			circleTimer.start()
		else:
			stunTimer.start(3.5)

func next()->void:
	staff.rotation_degrees = 0
	emit_signal("transitioned",self,nextState.name)
