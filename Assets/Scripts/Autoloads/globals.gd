extends Node


var apt_root : Node
var gb_root : Node
var gb_objects : Node
var gb_audio : Node
var gb_player : Node
var gb_dialogue_balloon = load("uid://c7d312wamnm5")
var gb_door : int = 0

var apt_object_spawner = load("uid://ckgyjteam2477")
var spawner_list : Array = []

var in_game : bool = false
var in_dialogue : bool = false
var in_game_time : float
var out_game_time : float
var paused_objects : Array[Node] = []
var summon_objects : Array[String]  = []
var held_tags : Array[StringName]
var throw_figure : bool = false

var progress_trackers  : Dictionary = {
	"switch_enabled" : true,
	"summon_enabled" : true,
	"home" : 0,
	"signo_warning" : false,
	"fat_cat_passed" : false,
	"fat_cat_fed" : false,
	"fat_cat_abandon_foods" : 0,
	"froggo_met" : false,
	"alien_spotted" : false,
	"alien_exited" : false,
	"doorway_unlocked" : false,
	"band_search" : false,
	"sewer_open" : false,
	"sewer_flushed" : false,
	"alien_girl_quest" : false,
	
	"ricky_rats_complete" : false,
	"cowboy_joe_complete" : false,
	"alien_girl_complete" :  false,
	"fat_cat_complete" : false,
	"ricky_rats_instrument" : "one",
	"cowboy_joe_instrument" : "one",
	"alien_girl_instrument" : "one",
	"fat_cat_instrument" : "one",
	
	"band_complete" : false,
	"concert_active" : false,
	
	
}

var dialogue_colours  : Dictionary = {
	"Default" : ["61393b" , "ffd3ad"],
	#"Fat Cat" : ["293268" , "b483ef"],
	#"Jacko" : ["b23c40" , "ffe091"],
}

func _ready() -> void:
	in_game = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


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

func gb_destroy_held():
	var grab = gb_player.grab_object
	gb_player.drop()
	grab.queue_free()

func free_spawners():
	for x in spawner_list:
		x.create()
	
	spawner_list = []

func assign_instrument(variable : String):
	var instrument : String = "None"
	
	if "guitar" in held_tags:
		instrument = "Guitar"
		gb_audio.fade_out_music(10.0)
		gb_audio.play("Guitar Track")
	elif "bass" in held_tags:
		instrument = "Bass"
		gb_audio.fade_out_music(10.0)
		gb_audio.play("Bass Track")
	elif "piano" in held_tags:
		instrument = "Piano"
		gb_audio.fade_out_music(10.0)
		gb_audio.play("Piano Track")
	elif "drum" in held_tags:
		print("yes")
		instrument = "Drum"
		gb_audio.fade_out_music(10.0)
		gb_audio.play("Drum Track")
	
	print(held_tags)
	
	if instrument in ["None",
		Globals.progress_trackers["ricky_rats_instrument"], 
		Globals.progress_trackers["fat_cat_instrument"],
		Globals.progress_trackers["cowboy_joe_instrument"],
		Globals.progress_trackers["alien_girl_instrument"]]:
			return false
	
	Globals.progress_trackers[variable] = instrument
	
	gb_destroy_held()
	
	return true
