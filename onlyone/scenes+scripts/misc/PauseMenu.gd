extends Node

var player:Player
var inCutscene:bool = false

var previousPos:Vector2
var previousHealth:float
var previousMax:float

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func start()->void:
	if get_tree().get_node_count_in_group("player")==1:
		player = get_tree().get_first_node_in_group("player")
		if previousPos:
			player.position = previousPos
			player.healthComp.maxHealth = previousMax
			player.healthComp.health = previousHealth
			player.updateHealthBar()

func _process(_delta: float) -> void:
	if player:
		if get_tree().paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		if !inCutscene:
			if Input.is_action_just_pressed("pause"):
				get_tree().paused = !get_tree().paused
			player.pauseScreen.visible = get_tree().paused
	else:
		start()

func changeScene(scene:String)->void:
	if player:
		previousPos = player.position
		previousHealth = player.healthComp.health
		previousMax = player.healthComp.maxHealth
	var newScene:Node = ResourceLoader.load(scene).instantiate()
	get_tree().current_scene.add_child.call_deferred(newScene)
	get_tree().current_scene.get_child(1).queue_free()
	player = null
	start.call_deferred()
