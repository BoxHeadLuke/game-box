class_name ScalePlayerTrigger
extends Trigger

@export var Scale : Vector2
@export var time : float

func start():
	Globals.gb_player.scale_player(Scale, time)
