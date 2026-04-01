extends Node3D

@export var Music : String = ""
@export var Music_Fade_Speed : float = 10.0

var music_faded

func _ready() -> void:
	Globals.gb_audio = self
	randomize()
	


func play(audio, play_whenever : bool = false):
	# Recieve a string and find the child with that name
	# Then choose a random sound from the children of that node and play it
	# Don't play sounds if the gamebox is paused
	if not play_whenever and not Globals.in_game:
		
		return
	
	var sound_set : Node
	
	
	sound_set = get_node(audio)
	
	sound_set.get_child(randi_range(0, sound_set.get_child_count() -1)).play()


func play_music(music):
	
	if music == Music:
		return
	
	if Music != "":
	
		get_node(Music + " GB").get_child(0).stop()
		get_node(Music + " APT").get_child(0).stop()
	
	Music = music
	
	
	
	get_node(Music + " GB").get_child(0).play()
	get_node(Music + " APT").get_child(0).play()
	
	if Globals.in_game:
		get_node(Music + " GB").get_child(0).volume_linear = 1
		get_node(Music + " APT").get_child(0).volume_linear = 0
	else:
		get_node(Music + " GB").get_child(0).volume_linear = 0
		get_node(Music + " APT").get_child(0).volume_linear = 0.1


func _process(delta: float) -> void:
	
	if Music == "":
		return
	
	if music_faded:
		print("yes")
		get_node(Music + " GB").get_child(0).volume_linear = move_toward(get_node(Music + " GB").get_child(0).volume_linear, 0, Music_Fade_Speed * delta)
		get_node(Music + " APT").get_child(0).volume_linear = move_toward(get_node(Music + " APT").get_child(0).volume_linear, 0, Music_Fade_Speed * delta)
	
	elif Globals.in_game:
		get_node(Music + " GB").get_child(0).volume_linear = move_toward(get_node(Music + " GB").get_child(0).volume_linear, 1, Music_Fade_Speed * delta)
		get_node(Music + " APT").get_child(0).volume_linear = move_toward(get_node(Music + " APT").get_child(0).volume_linear, 0, Music_Fade_Speed * delta)
	else:
		get_node(Music + " GB").get_child(0).volume_linear = move_toward(get_node(Music + " GB").get_child(0).volume_linear, 0, Music_Fade_Speed * delta)
		get_node(Music + " APT").get_child(0).volume_linear = move_toward(get_node(Music + " APT").get_child(0).volume_linear, 0.1, Music_Fade_Speed * delta)
	

func fade_out_music(time : float):
	
	music_faded = true
	
	await get_tree().create_timer(time).timeout
	music_faded = false
