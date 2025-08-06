extends State
class_name BlastState

@export var holder:CharacterBody2D
@export var nextState:State

func enter()->void:
	var blast:BlastAttack = ResourceLoader.load("res://scenes+scripts/player/attacks/blast.tscn").instantiate()
	holder.get_parent().add_child(blast)
	blast.global_position = holder.global_position
	blast.direction = (holder.get_global_mouse_position()-holder.global_position).normalized()
	blast.look_at(holder.get_global_mouse_position())
	blast.velocity = holder.velocity
	emit_signal("transitioned",self,nextState.name)
