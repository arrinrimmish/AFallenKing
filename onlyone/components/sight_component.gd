extends Area2D
class_name SightComponent

@export var targetGroup:String
@export var canLeave:bool
@export var pickClosest:bool
@export var storeAll:bool = false

var canSee:bool = false
var target:CharacterBody2D
var targets:Array

func _ready() -> void:
	if !body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	if !body_exited.is_connected(_on_body_exited):
		body_entered.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(targetGroup):
		if storeAll:
			targets += [body]
			canSee = true
			return
		elif canSee and pickClosest:
			if body.global_position-global_position < global_position-target.global_position:
				canSee = true
				target = body
			return
		canSee = true
		target = body


func _on_body_exited(body: Node2D) -> void:
	if canLeave:
		if storeAll and targets.has(body):
			targets.remove_at(targets.find(body))
			if targets.is_empty():
				canSee = false
		if body == target:
			target = null
			canSee = false
