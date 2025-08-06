extends CharacterBody2D
class_name Player

@export var healthComp:HealthComponent
@export var mask:Polygon2D
@export var empty:Polygon2D
@export var hitPoint:Polygon2D
@export var healthBar:Polygon2D
@export var particles:CPUParticles2D
@export var character:Polygon2D
@export var bossBar:Node2D
@export var bossLabel:RichTextLabel
@export var pauseScreen:Node2D
@export var questionBox:Polygon2D
@export var cursor:Polygon2D
@export var stateMachine:StateMachine
@export var deadState:PlayerDeadState

var fightingBoss:bool = false
var bossHealth:HealthComponent
var bossName:String

var questioner:Node

var dead:bool = false

func _ready() -> void:
	print("hello")
	updateHealthBar()
	$CanvasLayer.visible = true

func updateHealthBar()->void:
	var previousPoint:Polygon2D = hitPoint
	var distance:float = 22+24*(healthComp.maxHealth-1)
	healthBar.polygon = [Vector2(0,-5),Vector2(0,-17),Vector2(distance-4,-17),Vector2(distance,-11),Vector2(distance-4,-5)]
	mask.polygon = [Vector2(0,0),Vector2(0,-22),Vector2(distance,-22),Vector2(distance,0)]
	empty.polygon = [Vector2(0,0),Vector2(0,-22),Vector2(distance,-22),Vector2(distance,0)]
	for i in range(healthComp.maxHealth-1):
		var newPoint:Polygon2D = hitPoint.duplicate()
		var emptyPoint:Polygon2D = hitPoint.duplicate()
		mask.add_child(newPoint)
		empty.add_child(emptyPoint)
		newPoint.position = previousPoint.position+ Vector2(24,0)
		emptyPoint.position = previousPoint.position+ Vector2(24,0)
		previousPoint = newPoint
	mask.offset.x = -24*(healthComp.maxHealth-healthComp.health)

func hit(_attack:Attack)->void:
	if healthComp.health <=0:
		var current:State = stateMachine.currentState
		current.emit_signal("transitioned",current,deadState.name)
	mask.offset.x = -24*(healthComp.maxHealth-healthComp.health)

func death()->void:
	particles.emitting = true
	particles.one_shot = false
	particles.explosiveness = 0
	character.modulate = Color.TRANSPARENT
	dead = true

func _on_i_frame_timer_timeout() -> void:
	if $StateMachine.currentState != $StateMachine/spiritState:
		$components/HitBoxComponent.invulnerable = false

func _process(_delta: float) -> void:
	if !get_tree().paused:
		cursor.global_position = get_global_mouse_position()
		var mouse_offset:Vector2 = (get_viewport().get_mouse_position() - Vector2(get_viewport().size / 2))
		$Camera2D.position = lerp(Vector2(), mouse_offset.normalized() * 100, mouse_offset.length() / 900)
	if fightingBoss:
		$CanvasLayer/bossBar/bar.max_value = bossHealth.maxHealth
		$CanvasLayer/bossBar/bar.value = bossHealth.health
		bossLabel.text = "[center]"+bossName+"[/center]"
		$CanvasLayer/bossBar.visible = true
	else:
		$CanvasLayer/bossBar.visible = false


func _on_yes_pressed() -> void:
	if questioner:
		questioner.yes()

func _on_no_pressed() -> void:
	if questioner:
		questioner.no()


func _on_damage_body_entered(body: Node2D) -> void:
	if body is HitBoxComponent:
		var attack:Attack = Attack.new()
		attack.damage = 1
		attack.knockBack = 200
		attack.target = "enemy"
		attack.direction = body.global_position-global_position
		body.hit(attack)
		if body.holder.is_in_group("enemy"):
			var selfAttack:Attack = Attack.new()
			selfAttack.damage = 1
			selfAttack.target = "player"
			healthComp.hit(selfAttack)
