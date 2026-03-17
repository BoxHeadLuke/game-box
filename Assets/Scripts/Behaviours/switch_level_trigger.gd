class_name SwitchLevelTrigger
extends Trigger

@export var level : String
@export var door : int

func start():
	print("You got doored B)")
	Globals.gb_door = door
	
	Globals.gb_root.switch_level(level)
	
