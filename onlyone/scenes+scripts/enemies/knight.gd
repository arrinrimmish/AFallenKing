extends CharacterBody2D
class_name KnightBoss

@export var healthComp:HealthComponent
@export var stateMachine:StateMachine
@export var centerState:CenterMoveState
@export var particles:CPUParticles2D
@export var deathTimer:Timer
@export var arenaCenter:Marker2D
@export var music:AudioStreamPlayer

var stage1:bool = false
var stage2:bool = false

var camera:Camera2D

func death()->void:
	var musicTween:Tween = create_tween()
	musicTween.tween_property(music,"volume_db",-80,3)
	camera = get_viewport().get_camera_2d()
	camera.global_position = global_position
	particles.process_mode = Node.PROCESS_MODE_ALWAYS
	PauseMenu.inCutscene = true
	particles.get_parent().position.x = 0
	particles.lifetime = 2.5
	particles.one_shot = false
	particles.explosiveness = 0
	particles.emitting = true
	PauseMenu.player.fightingBoss = false
	PauseMenu.player.bossHealth = null
	get_tree().paused = true
	deathTimer.start(3)
	


func _on_death_timer_timeout() -> void:
	print(music.volume_db)
	get_tree().paused = false
	PauseMenu.inCutscene = false
	var corpse:CharacterBody2D = ResourceLoader.load("res://scenes+scripts/enemies/Power_corpse.tscn").instantiate()
	get_tree().current_scene.get_child(1).add_child.call_deferred(corpse)
	print(get_tree().current_scene.get_child(1).name)
	corpse.global_position = global_position
	corpse.rotation_degrees = $square.rotation_degrees
	queue_free()
