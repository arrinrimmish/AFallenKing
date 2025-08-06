extends Node
class_name KnockBackComponent

@export var holder:CharacterBody2D
@export var resistance:float

func hit(attack:Attack)->void:
	holder.velocity += attack.direction.normalized()*attack.knockBack*resistance
