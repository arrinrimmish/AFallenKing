extends CharacterBody2D
class_name MageBoss

@export var healthComp:HealthComponent
@export var particles:CPUParticles2D
@export var deathTimer:Timer
@export var character:Polygon2D
@export var teleport:Node2D
@export var music:AudioStreamPlayer

var camera:Camera2D

func _ready() -> void:
	deathTimer.timeout.connect(die)

func death()->void:
	var musicTween:Tween = create_tween()
	musicTween.tween_property(music,"volume_db",-80,3)
	global_position = teleport.global_position
	character.visible = true
	camera = get_viewport().get_camera_2d()
	camera.global_position = character.global_position
	particles.process_mode = Node.PROCESS_MODE_ALWAYS
	PauseMenu.inCutscene = true
	particles.one_shot = false
	particles.explosiveness = 0
	particles.emitting = true
	PauseMenu.player.fightingBoss = false
	PauseMenu.player.bossHealth = null
	get_tree().paused = true
	deathTimer.start(3)

func die()->void:
	get_tree().paused = false
	PauseMenu.inCutscene = false
	var corpse:CharacterBody2D = ResourceLoader.load("res://scenes+scripts/enemies/Power_corpse.tscn").instantiate()
	get_tree().current_scene.get_child(1).add_child.call_deferred(corpse)
	corpse.global_position = global_position
	corpse.rotation_degrees = character.rotation_degrees
	queue_free()
