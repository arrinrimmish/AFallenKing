extends Node
class_name HealthComponent

@export var holder:CharacterBody2D
@export var maxHealth:float
@export var notifyHolder:bool = false
@export var invulnerable:bool = false

var health:float

func _ready() -> void:
	health = maxHealth

func hit(attack:Attack)->void:
	if invulnerable:
		return
	health -= attack.damage
	if notifyHolder:
		if holder.has_method("hit"):
			holder.hit(attack)
		else:
			print("holder %s has no hit function"%[holder.name])
	if health <= 0:
		if holder.has_method("death"):
			holder.death()
		else:
			holder.queue_free()
