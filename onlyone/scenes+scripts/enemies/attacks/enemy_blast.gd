extends CharacterBody2D
class_name EnemyBlast

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
	if !body is EnemyBlast and !body is Corpse:
		$triangle.visible = false
		$CPUParticles2D.emitting = true
		$triangle/Area2D/CollisionShape2D.set_deferred("disabled",true)
		var boomTween:Tween = create_tween()
		boomTween.tween_interval(0.25)
		boomTween.tween_callback(queue_free.call_deferred)
		if body is HitBoxComponent:
			var attack:Attack = Attack.new()
			attack.damage = damage
			attack.direction = (body.holder.global_position-global_position).normalized()
			attack.knockBack = damage*200
			attack.target = "player"
			body.hit(attack)
			
