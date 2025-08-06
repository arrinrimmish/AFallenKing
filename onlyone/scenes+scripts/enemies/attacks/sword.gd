extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "HitBoxComponent":
		var attack:Attack = Attack.new()
		attack.damage = 1
		attack.direction = body.global_position-global_position
		attack.knockBack = 200
		attack.target = "player"
		body.hit(attack)
