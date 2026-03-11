extends Node


var apt_root : Node
var gb_root : Node
var gb_objects : Node
var gb_audio : Node
var gb_player : Node
var gb_dialogue_balloon = load("uid://c7d312wamnm5")

var in_game : bool = false
var in_dialogue : bool = false
var in_game_time : float
var out_game_time : float
var paused_objects : Array[Node] = []
var summon_objects : Array[String]  = []
var held_tags : Array[StringName]

var progress_trackers  : Dictionary = {
	"switch_enabled" : false,
	"summon_enabled" : false,
	"home" : 0,
	"fat_cat" : 0,
}

var dialogue_colours  : Dictionary = {
	"Default" : ["61393b" , "ffd3ad"],
	#"Fat Cat" : ["293268" , "b483ef"],
	#"Jacko" : ["b23c40" , "ffe091"],
}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _process(delta: float) -> void:
	
	if in_game:
		in_game_time += delta
		out_game_time = 0.0
	else:
		in_game_time = 0.0
		out_game_time += delta
	
	
	if Input.is_action_just_pressed("Switch") and not in_dialogue and progress_trackers["switch_enabled"]:
		in_game = not in_game
		
		
		
		if in_game:
			
			for grab_obj in get_tree().get_nodes_in_group("grab_objects"):
				if grab_obj is RigidBody2D:
					grab_obj.freeze = false
			
			for obj in paused_objects:
				obj.process_mode = obj.PROCESS_MODE_DISABLED
		else:
			for grab_obj in get_tree().get_nodes_in_group("grab_objects"):
				if grab_obj is RigidBody2D:
					grab_obj.freeze = true
