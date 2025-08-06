extends State
class_name SpititState

@export var holder:CharacterBody2D
@export var speed:float
@export var rotationSpeed:float
@export var point:Node2D
@export var body:Polygon2D
@export var particles:CPUParticles2D
@export var sight:SightComponent
@export var goToSight:SightComponent
@export var nextState:State
@export var spirit:Node
@export var lengths:PackedInt32Array
@export var progressBar:TextureProgressBar
@export var spiritTime:float
@export var hitBoxhComp:HitBoxComponent
@export var healthComp:HealthComponent
@export var iframeTimer:Timer
@export var collision:CollisionShape2D
@export var attackCollision:CollisionShape2D

var change:bool = false

func enter()->void:
	#attackCollision.set_deferred("disabled",false)
	collision.set_deferred("disabled",true)
	sight.get_child(0).disabled = true
	sight.get_child(0).disabled = false
	hitBoxhComp.invulnerable = true
	point.look_at(holder.global_position+holder.velocity)
	progressBar.visible = true
	progressBar.max_value = spiritTime
	progressBar.value = spiritTime
	for i in spirit.get_children():
		i.visible = true
	body.visible = false
	particles.emitting = true

func exit()->void:
	attackCollision.set_deferred("disabled",true)
	collision.set_deferred("disabled",false)
	progressBar.visible = false
	for i in spirit.get_children():
		i.visible = false
	body.visible = true
	particles.emitting = true
	iframeTimer.start()

func update(delta:float)->void:
	if holder.is_in_group("player"):
		if holder.dead:
			emit_signal("transitioned",self,"playerDeadState")
	progressBar.value -= 1*delta
	if progressBar.value <= 0:
		var attack:Attack = Attack.new()
		attack.damage = 1
		attack.target = "player"
		healthComp.hit(attack)
		progressBar.value = 1.5
	spirit.get_child(0).look_at(holder.global_position)
	spirit.get_child(0).global_position = holder.global_position
	var number:int = 0
	var previousSeg:Polygon2D = spirit.get_child(0)
	for seg:Polygon2D in spirit.get_children():
		seg.global_position = previousSeg.global_position+(seg.global_position-previousSeg.global_position).normalized()*lengths[number]
		seg.look_at(previousSeg.global_position)
		previousSeg = seg
		number += 1
	if sight.canSee:
		sight.target.queue_free()
		sight.canSee = false
		sight.target = null
		sight.targets = []
		emit_signal("transitioned",self,nextState.name)

func physicsUpdate(delta:float)->void:
	holder.velocity = (point.get_child(0).global_position-holder.global_position)*speed*delta
	if goToSight.canSee:
		holder.velocity*=2
		point.look_at(goToSight.target.global_position)
	elif Input.is_action_pressed("left"):
		point.rotation_degrees -= 1*rotationSpeed*delta
	elif Input.is_action_pressed("right"):
		point.rotation_degrees += 1*rotationSpeed*delta
	
	holder.move_and_slide()
