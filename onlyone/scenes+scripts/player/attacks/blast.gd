extends CharacterBody2D
class_name BlastAttack

@export var speed:float
@export var drag:float
@export var maxSpeed:float
@export var damage:float

var direction:Vector2

func _physics_process(delta: float) -> void:
	if velocity.length() <= 5:
		velocity -= velocity.normalized()*drag*delta
	if velocity.length() < maxSpeed:
		velocity += direction*speed*delta
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body.is_in_group("player"):
		if body.name == "HitBoxComponent":
			if body.holder.is_in_group("player"):
				return
			velocity = Vector2.ZERO
			$triangle.visible = false
			$CPUParticles2D.emitting = true
			$triangle/blastRadius/CollisionShape2D.set_deferred("disabled",false)
			var boomTween:Tween = create_tween()
			boomTween.tween_property($triangle/blastRadius/CollisionShape2D,"scale",Vector2(3.2,3.2),0.25)
			boomTween.tween_callback(queue_free.call_deferred)


func _on_timer_timeout() -> void:
	$Area2D/CollisionShape2D.disabled = false


func _on_blast_radius_body_entered(body: Node2D) -> void:
	if body.name == "HitBoxComponent":
		var attack:Attack = Attack.new()
		attack.damage = damage
		attack.direction = (body.holder.global_position-global_position).normalized()
		attack.knockBack = damage*200
		attack.target = "enemy"
		body.hit(attack)
