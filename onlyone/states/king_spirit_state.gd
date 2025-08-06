extends State
class_name KingSpiritState

@export var holder:CharacterBody2D
@export var speed:float
@export var sight:SightComponent
@export var teleport:Node2D
@export var point:Marker2D
@export var texture:Node2D
@export var particles:CPUParticles2D
@export var nextState:State
@export var spirit:Node2D
@export var lengths:PackedInt32Array
@export var hitBoxhComp:HitBoxComponent
@export var collision:CollisionShape2D

var targetPoint:Vector2

func _ready() -> void:
	teleport.global_position = holder.global_position

func enter()->void:
	var previousPoint:Vector2 = point.global_position
	while (sight.target.global_position-point.global_position).length() <= 250 or point.global_position == previousPoint:
		teleport.rotation_degrees = randi_range(0,-180)
		point.position.x = randi_range(0,275)
	collision.set_deferred("disabled",true)
	hitBoxhComp.invulnerable = true
	spirit.visible = true
	texture.visible = false
	particles.emitting = true

func exit()->void:
	collision.set_deferred("disabled",false)
	hitBoxhComp.invulnerable = false
	spirit.visible = false
	texture.visible = true
	particles.emitting = true

func update(_delta:float)->void:
	spirit.get_child(0).look_at(holder.global_position)
	spirit.get_child(0).global_position = holder.global_position
	var number:int = 0
	var previousSeg:Polygon2D = spirit.get_child(0)
	for seg:Polygon2D in spirit.get_children():
		seg.global_position = previousSeg.global_position+(seg.global_position-previousSeg.global_position).normalized()*lengths[number]
		seg.look_at(previousSeg.global_position)
		previousSeg = seg
		number += 1
	if (point.global_position-holder.global_position).length()<=10:
		emit_signal("transitioned",self,nextState.name)

func physicsUpdate(delta:float)->void:
	point.look_at(targetPoint)
	holder.velocity = (point.global_position-holder.global_position).normalized()*speed*delta
	holder.move_and_slide()
