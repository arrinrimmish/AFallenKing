extends State
class_name KingSlashState

@export var holder:CharacterBody2D
@export var sight:SightComponent
@export var nextState:State
@export var sword:Area2D
@export var character:Polygon2D
@export var delay:float
@export var slashPath:String = "res://scenes+scripts/enemies/attacks/slash.tscn"
@export var shots:Node2D
@export var shoot:bool = true
@export var followSpeed:int = 350



func enter()->void:
	var angleChange:int = 0
	if shoot:
		shots.look_at(sight.target.global_position)
		for i:Marker2D in shots.get_children():
			var blast:KingBlast = ResourceLoader.load("res://scenes+scripts/enemies/attacks/king_blast.tscn").instantiate()
			get_tree().current_scene.add_child(blast)
			blast.global_position = i.global_position
			blast.direction = i.global_position-holder.global_position
			blast.enter()
			blast.velocity += (i.global_position-holder.global_position)*40
			blast.rotationSpeed = followSpeed
	for i:CollisionPolygon2D in sword.get_children():
		i.set_deferred("disabled",false)
		var slash:Slash = ResourceLoader.load(slashPath).instantiate()
		holder.add_child(slash)
		slash.look_at(sight.target.global_position)
		slash.scale.y = i.scale.x
		slash.rotation_degrees += 180
		var slashTween:Tween = create_tween()
		slashTween.tween_property(i,"rotation_degrees",i.rotation_degrees+180,0.1)
		slashTween.tween_interval(delay)
		slashTween.tween_property(i,"rotation_degrees",-100+angleChange,0)
		slashTween.tween_callback(emit_signal.bind("transitioned",self,nextState.name))
		angleChange = 20

func exit()->void:
	for i in sword.get_children():
		i.set_deferred("disabled",true)

func update(delta:float)->void:
	character.rotation_degrees += 210*delta
