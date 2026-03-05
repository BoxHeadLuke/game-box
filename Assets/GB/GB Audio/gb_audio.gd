extends Node3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.gb_audio = self
	randomize()

func play(audio):
	
	if not Globals.in_game:
		return
	
	var sound_set : Node
	
	
	sound_set = get_node(audio)
	
	#sound_set.get_child(randi_range(0, sound_set.get_child_count() -1)).stop()
	sound_set.get_child(randi_range(0, sound_set.get_child_count() -1)).play()
