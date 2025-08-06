extends State
class_name KingDragonState

@export var holder:CharacterBody2D
@export var character:Polygon2D
@export var particles:CPUParticles2D
@export var dragonSize:int
@export var spawnParticles1:CPUParticles2D
@export var spawnParticles2:CPUParticles2D
@export var spawnTimer:Timer
@export var summons:Node2D
@export var manageState:KingManageState

var dragon:DragonHead

func _ready() -> void:
	summons.global_position = holder.global_position
	spawnTimer.timeout.connect(spawn)

func enter()->void:
	particles.emitting = true
	spawnTimer.start(0.5)

func exit()->void:
	particles.emitting = false

func spawn()->void:
	if !spawnParticles1.emitting:
		spawnParticles1.global_position = summons.get_child(0).global_position
		spawnParticles2.global_position = summons.get_child(1).global_position
		spawnParticles1.emitting = true
		spawnParticles2.emitting = true
		spawnTimer.start(2)
		return
	spawnParticles1.emitting = false
	spawnParticles2.emitting = false
	for i in range(2):
		dragon = ResourceLoader.load("res://scenes+scripts/enemies/king_dragon_head.tscn").instantiate()
		dragon.size = dragonSize
		dragon.global_position = summons.get_child(i-1).global_position
		get_tree().current_scene.add_child(dragon)
		dragon.dying.connect(manageState.dragonDie)
	emit_signal("transitioned",self,manageState.name)

func update(delta:float)->void:
	character.rotation_degrees += 90*delta
