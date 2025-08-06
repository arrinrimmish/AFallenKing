extends State
class_name MageShootState

@export var staff:Node2D
@export var orb1:Polygon2D
@export var orb2:Polygon2D
@export var orbs:Node2D
@export var nextState:State
@export var character:Polygon2D
@export var sight:SightComponent

func enter()->void:
	var startTween:Tween = create_tween()
	startTween.tween_property(orbs,"scale",Vector2(3.5,3.5),0.6)
	startTween.tween_callback(send)
	startTween.tween_property(staff,"rotation_degrees",staff.rotation_degrees-130,0.12)
	startTween.tween_property(orbs,"scale",Vector2(1,1),0.12)
	startTween.set_parallel(false)
	startTween.tween_property(staff,"rotation_degrees",staff.rotation_degrees,0.5)
	startTween.tween_callback(emit_signal.bind("transitioned",self,nextState.name))



func update(delta:float)->void:
	character.rotation_degrees += 90*delta
	orb1.rotation_degrees += 90*delta
	orb2.rotation_degrees -= 90*delta

func send()->void:
	for i in range(5):
		var blast:EnemyBlast = ResourceLoader.load("res://scenes+scripts/enemies/attacks/enemy_blast.tscn").instantiate()
		get_tree().current_scene.add_child(blast)
		blast.global_position = orbs.global_position+Vector2(randi_range(-5,5),randi_range(-5,5))
		blast.direction = (sight.target.global_position-orbs.global_position).normalized()
		blast.direction += Vector2(randf_range(-0.3,0.3),randf_range(-0.3,0.3))
		blast.look_at(sight.target.global_position)
