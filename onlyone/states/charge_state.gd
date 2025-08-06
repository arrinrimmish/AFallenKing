extends State
class_name ChargeState

@export var character:Polygon2D
@export var weapon:Node2D
@export var chargeTime:float
@export var nextState:State
@export var timer:Timer

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)

func enter()->void:
	timer.start(chargeTime)
	

func update(delta:float)->void:
	weapon.rotation_degrees -= 180*delta
	character.rotation_degrees += 50*delta

func on_timer_timeout()->void:
	emit_signal("transitioned",self,nextState.name)
