class_name DialogueTrigger
extends Node

@export var Dialogue_File : DialogueResource
@export var Start_Flag : String

func start():
	
	var d = Globals.gb_dialogue_balloon.instantiate()
	Globals.gb_root.add_child(d)
	d.start(Dialogue_File , Start_Flag)
