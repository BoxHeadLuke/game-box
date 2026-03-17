class_name LevelDoor
extends Marker2D

@export var door_number : int = 1

func _ready() -> void:
	if door_number != Globals.gb_door:
		return
	
	while not Globals.gb_player:
		await get_tree().process_frame
	
	Globals.gb_player.global_position = global_position
