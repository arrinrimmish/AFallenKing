extends CharacterBody2D
class_name KingBoss

@export var stateMachine:StateMachine
@export var moveState:MoveState
@export var spiritState:KingSpiritState
@export var particles:CPUParticles2D
@export var deathTimer:Timer
@export var character:Polygon2D
@export var music:AudioStreamPlayer

signal end_game

func _ready() -> void:
	deathTimer.timeout.connect(die)

func death()->void:
	var musicTween:Tween = create_tween()
	musicTween.tween_property(music,"volume_db",-80,3)
	velocity =  Vector2.ZERO
	var currentState:State = stateMachine.currentState
	moveState.process_mode = Node.PROCESS_MODE_ALWAYS
	currentState.emit_signal("transitioned",currentState,moveState.name)
	get_viewport().get_camera_2d().global_position = global_position
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

func die()->void:
	get_tree().paused = false
	PauseMenu.inCutscene = false
	var corpse:CharacterBody2D = ResourceLoader.load("res://scenes+scripts/enemies/Power_corpse.tscn").instantiate()
	get_tree().current_scene.get_child(1).add_child.call_deferred(corpse)
	corpse.global_position = global_position
	corpse.rotation_degrees = character.rotation_degrees
	emit_signal("end_game")
	queue_free()

func hit(_attack:Attack)->void:
	stateMachine.currentState.emit_signal("transitioned",stateMachine.currentState,spiritState.name)


func _on_cutscene_burst_body_entered(body: Node2D) -> void:
	if body is HitBoxComponent:
		var attack:Attack = Attack.new()
		attack.damage = 1
		attack.target = "civilian"
		body.hit(attack)
