extends Node3D


func _ready() -> void:
	Globals.gb_audio = self
	randomize()


func play(audio):
	# Recieve a string and find the child with that name
	# Then choose a random sound from the children of that node and play it
	# Don't play sounds if the gamebox is paused
	if not Globals.in_game:
		return
	
	var sound_set : Node
	
	
	sound_set = get_node(audio)
	
	sound_set.get_child(randi_range(0, sound_set.get_child_count() -1)).play()
