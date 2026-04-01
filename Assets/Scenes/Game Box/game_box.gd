extends Node2D

@export var start_level : String
@export var HUD : CanvasLayer
@export var Level_Parent : Node2D
@export var Balloon_Parent : Node2D

var in_test : bool = false

func _ready() -> void:
	switch_level(start_level)

#func _process(delta: float) -> void:
	#return
	#if Input.is_action_just_pressed("Use"):
		#in_test = not in_test
		#
		#if in_test:
			#switch_level("uid://cocknyls7ik1h")
		#else:
			#switch_level("uid://3722kpav0b6h")

func switch_level(new_level : String):
	HUD.trans_out()
	
	await get_tree().create_timer(0.5).timeout
	
	for l in Level_Parent.get_children():
		l.queue_free()
	for b in Balloon_Parent.get_children():
		b.queue_free()
		Globals.in_dialogue = false
	
	Level_Parent.add_child(load(new_level).instantiate())
	
	Globals.free_spawners()
	
	await get_tree().create_timer(0.5).timeout
	
	HUD.trans_in()
	

func add_balloon(balloon):
	Balloon_Parent.add_child(balloon)
	
