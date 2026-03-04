extends Node

var in_game = false

var paused_objects = []

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Switch"):
		in_game = not in_game
		
		if in_game:
			for obj in paused_objects:
				obj.process_mode = obj.PROCESS_MODE_DISABLED
	
