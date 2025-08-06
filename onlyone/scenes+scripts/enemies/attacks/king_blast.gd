extends CharacterBody2D
class_name KingBlast

@export var speed:float
@export var drag:float
@export var maxSpeed:float
@export var damage:float
@export var character:Polygon2D
@export var sight:SightComponent
@export var follow:Node2D
@export var point:Marker2D
@export var rotationSpeed:float

var direction:Vector2


func enter()->void:
	follow.look_at(global_position+direction)

func _physics_process(delta: float) -> void:
	point.position.x = 1
	character.look_at(point.global_position)
	character.rotation_degrees += 90
	if sight.canSee:
		follow.rotation_degrees += sign(follow.get_angle_to(sight.target.global_position))*rotationSpeed*delta
	if velocity.length() >= 5:
		velocity -= velocity.normalized()*drag*delta
	if velocity.length() < maxSpeed:
		velocity += (point.global_position-global_position).normalized()*(drag+speed)*delta
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
		if body.name == "HitBoxComponent":
			if body.holder.is_in_group("king"):
				return
			velocity = Vector2.ZERO
			$triangle.visible = false
			$CPUParticles2D.emitting = true
			$triangle/blastRadius/CollisionShape2D.set_deferred("disabled",false)
			var boomTween:Tween = create_tween()
			boomTween.tween_property($triangle/blastRadius/CollisionShape2D,"scale",Vector2(1.25,1.25),0.25)
			boomTween.tween_callback(queue_free.call_deferred)


func _on_timer_timeout() -> void:
	velocity = Vector2.ZERO
	$triangle.visible = false
	$CPUParticles2D.emitting = true
	$triangle/blastRadius/CollisionShape2D.set_deferred("disabled",false)
	var boomTween:Tween = create_tween()
	boomTween.tween_property($triangle/blastRadius/CollisionShape2D,"scale",Vector2(4,4),0.25)
	boomTween.tween_callback(queue_free.call_deferred)


func _on_blast_radius_body_entered(body: Node2D) -> void:
	if body.name == "HitBoxComponent":
		var attack:Attack = Attack.new()
		attack.damage = damage
		attack.direction = (body.holder.global_position-global_position).normalized()
		attack.knockBack = damage*200
		attack.target = "player"
		body.hit(attack)
