extends State
class_name KingRageState

@export var holder:CharacterBody2D
@export var healthComp:HealthComponent
@export var character:Polygon2D
@export var particles:CPUParticles2D
@export var stateMachine:StateMachine
@export var timer:Timer
@export var moveTimer:Timer
@export var nextState:State
@export var burstParticles:CPUParticles2D
@export var burstCollision:CollisionShape2D
@export var music:AudioStreamPlayer

var camera:Camera2D
var previousCameraPos:Vector2

var stage1:bool = false

func _ready() -> void:
	moveTimer.timeout.connect(doneMove)
	timer.timeout.connect(next)

func enter()->void:
	particles.process_mode = Node.PROCESS_MODE_ALWAYS
	camera = get_viewport().get_camera_2d()
	camera.global_position = holder.global_position
	camera.position_smoothing_speed = 2.0
	stateMachine.process_mode = Node.PROCESS_MODE_ALWAYS
	PauseMenu.inCutscene = true
	PauseMenu.player.fightingBoss = true
	PauseMenu.player.bossHealth = healthComp
	PauseMenu.player.bossName = "The King of The Darkness"
	get_tree().paused = true
	moveTimer.start(1.75)

func update(delta:float)->void:
	if stage1:
		character.rotation_degrees += 360*delta

func doneMove()->void:
	stage1 = true
	particles.emitting = true
	var readyTween:Tween = create_tween()
	readyTween.tween_property(particles,"scale",Vector2(0.1,0.1),1.5)
	timer.start(1.5)
	

func next()->void:
	music.playing = true
	camera.position_smoothing_speed = 8
	var burstTween:Tween = create_tween()
	burstTween.tween_property(burstCollision.shape,"radius",500,0.8)
	burstParticles.emitting = true
	stateMachine.process_mode = Node.PROCESS_MODE_INHERIT
	particles.process_mode = Node.PROCESS_MODE_INHERIT
	PauseMenu.inCutscene = false
	get_tree().paused = false
	emit_signal("transitioned",self,nextState.name)
