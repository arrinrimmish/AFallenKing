extends State
class_name ShootState

@export var staff:Node2D
@export var orb1:Polygon2D
@export var orb2:Polygon2D
@export var orbs:Node2D
@export var nextState:State
@export var character:Polygon2D
@export var sight:SightComponent

func enter()->void:
	var startTween:Tween = create_tween()
	startTween.tween_property(orbs,"scale",Vector2(3.5,3.5),0.85)
	startTween.tween_property(staff,"rotation_degrees",staff.rotation_degrees-130,0.12)
	startTween.set_parallel()
	startTween.tween_method(send,0.0,1.0,0.06)
	startTween.tween_property(orbs,"scale",Vector2(1,1),0.12)
	startTween.set_parallel(false)
	startTween.tween_property(staff,"rotation_degrees",staff.rotation_degrees,0.5)
	startTween.tween_callback(emit_signal.bind("transitioned",self,nextState.name))



func update(delta:float)->void:
	character.rotation_degrees += 90*delta
	orb1.rotation_degrees += 90*delta
	orb2.rotation_degrees -= 90*delta

func send(number:float)->void:
	if number == 1.0:
		var blast:EnemyBlast = ResourceLoader.load("res://scenes+scripts/enemies/attacks/enemy_blast.tscn").instantiate()
		get_tree().current_scene.add_child(blast)
		blast.global_position = orbs.global_position
		blast.direction = (sight.target.global_position-orbs.global_position).normalized()
		blast.look_at(sight.target.global_position)
