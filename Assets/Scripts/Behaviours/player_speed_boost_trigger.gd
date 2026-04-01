class_name PlayerSpeedBoostTrigger
extends Trigger

@export var boost : float = 1.0
@export var time : float = 20.0

func start():
	Globals.gb_player.player_speed_boost(boost, time)
