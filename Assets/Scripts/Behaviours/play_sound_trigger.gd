class_name PlayAudioTrigger
extends Trigger

@export var Use_GB_Audio : bool = true

@export var GB_Audio_Name : String = "Guitar"
@export var Audio_Player : Node

func start():
	if Use_GB_Audio:
		Globals.gb_audio.play(GB_Audio_Name)
	else:
		Audio_Player.play()
