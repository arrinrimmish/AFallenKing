extends State
class_name KnightRageState

@export var holder:CharacterBody2D
@export var healthComp:HealthComponent
@export var character:Polygon2D
@export var particles:CPUParticles2D
@export var stateMachine:StateMachine
@export var timer:Timer
@export var nextState:State
@export var music:AudioStreamPlayer

var camera:Camera2D
var previousCameraPos:Vector2

func _ready() -> void:
	timer.timeout.connect(next)

func enter()->void:
	camera = get_viewport().get_camera_2d()
	previousCameraPos = camera.global_position
	camera.global_position = holder.global_position
	stateMachine.process_mode = Node.PROCESS_MODE_ALWAYS
	particles.process_mode = Node.PROCESS_MODE_ALWAYS
	particles.lifetime = 2.5
	particles.emitting = true
	PauseMenu.inCutscene = true
	PauseMenu.player.fightingBoss = true
	PauseMenu.player.bossHealth = healthComp
	PauseMenu.player.bossName = "The Traitor's Knight"
	get_tree().paused = true
	timer.start(2.5)

func update(delta:float)->void:
	character.rotation_degrees += 360*delta

func next()->void:
	music.playing = true
	stateMachine.process_mode = Node.PROCESS_MODE_PAUSABLE
	particles.process_mode = Node.PROCESS_MODE_PAUSABLE
	particles.lifetime = 1
	#camera.global_position = previousCameraPos
	PauseMenu.inCutscene = false
	get_tree().paused = false
	emit_signal("transitioned",self,nextState.name)
