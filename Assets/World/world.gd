extends Node3D

@export var Appartment : Node3D
@export var GameBox : Node2D

@export var Screen_Cam : PhantomCamera3D


func _process(delta: float) -> void:
	
	
	if Globals.in_game:
		Screen_Cam.priority = 2
		#get_tree().paused = false
		Appartment.process_mode = Node.PROCESS_MODE_DISABLED
		GameBox.process_mode = Node.PROCESS_MODE_ALWAYS
	else:
		Screen_Cam.priority = 0
		#get_tree().paused = true
		GameBox.process_mode = Node.PROCESS_MODE_DISABLED
		Appartment.process_mode = Node.PROCESS_MODE_ALWAYS
