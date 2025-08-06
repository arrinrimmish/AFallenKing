extends CharacterBody2D
class_name DragonHead

@export var dragonPieces:Node
@export var healthComp:HealthComponent
@export var size:int = 3
@export var invTimer:Timer
@export var cooldown:Timer
@export var maxDamage:int = 3
@export var dragonPath:String="res://scenes+scripts/enemies/dragon.tscn"

signal dying

var damageTaken:int = 0

func _ready() -> void:
	invTimer.timeout.connect(outInv)
	cooldown.timeout.connect(reset)
	healthComp.maxHealth = size+1
	healthComp.health = size+1
	var previousPiece:Node = self
	for i:int in range(size):
		var piece:Dragon = ResourceLoader.load(dragonPath).instantiate()
		dragonPieces.add_child(piece)
		piece.global_position = global_position
		piece.moveState.target = previousPiece
		piece.position += Vector2(randf_range(-40,40),randf_range(-40,40))
		piece.velocity = Vector2.ZERO
		piece.hitBox.holder = self
		piece.hitBox.healthComponent = healthComp
		previousPiece = piece

func hit(_attack:Attack)->void:
	if dragonPieces.get_child_count()>0:
		damageTaken += 1
		dragonPieces.get_children()[-1].death()
		if damageTaken >=maxDamage:
			healthComp.invulnerable = true
			invTimer.start()
	else:
		death()

func outInv()->void:
	healthComp.invulnerable = false

func reset()->void:
	damageTaken = 0

func death()->void:
	var corpse:CharacterBody2D = ResourceLoader.load("res://scenes+scripts/enemies/corpse.tscn").instantiate()
	get_tree().current_scene.add_child.call_deferred(corpse)
	corpse.global_position = global_position
	corpse.rotation_degrees = $square.rotation_degrees
	emit_signal("dying")
	queue_free.call_deferred()
