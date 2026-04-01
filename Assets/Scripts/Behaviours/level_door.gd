class_name LevelDoor
extends Marker2D

@export var door_number : int = 1
@export var face_left : bool

func _ready() -> void:
	if door_number != Globals.gb_door:
		return
	
	while not Globals.gb_player:
		await get_tree().process_frame
		print("yes")
	print(name)
	Globals.gb_player.global_position = global_position
	print(global_position)
	await get_tree().process_frame
	Globals.gb_player.global_position = global_position
	if face_left:
		Globals.gb_player.start_flip()
