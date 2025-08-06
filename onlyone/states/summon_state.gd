extends State
class_name SummonState

@export var squireRotation:Node2D
@export var squireSpawn:Marker2D
@export var startSummonAmount:int
@export var summonType:String
@export var particles:CPUParticles2D
@export var timer:Timer
@export var waitTimer:Timer
@export var nextState:State
@export var weapon:Node2D
@export var hitBox:HitBoxComponent

var summonAmount:int

func _ready() -> void:
	timer.timeout.connect(summon)
	waitTimer.timeout.connect(wait)
	

func enter()->void:
	hitBox.invulnerable = true
	summonAmount = startSummonAmount
	weapon.rotation_degrees = 0
	startSummon()

func exit()->void:
	hitBox.invulnerable = false

func startSummon()->void:
	summonAmount-=1
	particles.emitting = true
	squireRotation.rotation_degrees = randi_range(0,360)
	squireSpawn.position.x = randi_range(75,200)
	timer.start(1)

func summon()->void:
	var newSummon:Node2D = ResourceLoader.load(summonType).instantiate()
	get_tree().current_scene.add_child(newSummon)
	newSummon.global_position = squireSpawn.global_position
	waitTimer.start()

func wait()->void:
	if summonAmount > 0:
		startSummon()
	else:
		emit_signal("transitioned",self,nextState.name)
