extends State
class_name MageDragonState

@export var holder:CharacterBody2D
@export var teleport:Node2D
@export var collision1:CollisionShape2D
@export var collision2:CollisionShape2D
@export var mageTexture:Node2D
@export var particles:CPUParticles2D
@export var dragonSize:int
@export var spawnParticles:CPUParticles2D
@export var spawnTimer:Timer
@export var nextState:State

var dragon:DragonHead

func _ready() -> void:
	spawnTimer.timeout.connect(spawn)

func enter()->void:
	collision1.disabled = true
	collision2.disabled = true
	particles.emitting = true
	mageTexture.visible = false
	spawnTimer.start(0.5)

func spawn()->void:
	if !spawnParticles.emitting:
		spawnParticles.global_position = teleport.global_position
		spawnParticles.emitting = true
		spawnTimer.start(2)
		return
	holder.global_position = teleport.global_position + Vector2(400,400)
	spawnParticles.emitting = false
	dragon = ResourceLoader.load("res://scenes+scripts/enemies/dragon_head.tscn").instantiate()
	dragon.size = dragonSize
	dragon.global_position = teleport.global_position
	get_tree().current_scene.add_child(dragon)
	dragon.dying.connect(dead)


func dead()->void:
	holder.global_position = teleport.global_position
	particles.emitting = true
	collision1.set_deferred("disabled",false)
	collision2.set_deferred("disabled",false)
	emit_signal("transitioned",self,nextState.name)
