extends State
class_name KnightSlashState

@export var holder:CharacterBody2D
@export var sight:SightComponent
@export var nextState:State
@export var sword:Area2D
@export var weaponCollision:CollisionPolygon2D
@export var character:Polygon2D
@export var delay:float
@export var slashPath:String = "res://scenes+scripts/enemies/attacks/slash.tscn"



func enter()->void:
	weaponCollision.disabled = false
	var slash:Slash = ResourceLoader.load(slashPath).instantiate()
	holder.add_child(slash)
	slash.look_at(sight.target.global_position)
	slash.rotation_degrees += 180
	var slashTween:Tween = create_tween()
	slashTween.tween_property(sword,"rotation_degrees",sword.rotation_degrees+180,0.1)
	slashTween.tween_interval(0.8)
	slashTween.tween_callback(emit_signal.bind("transitioned",self,nextState.name))

func exit()->void:
	weaponCollision.disabled = true

func update(delta:float)->void:
	character.rotation_degrees += 210*delta
