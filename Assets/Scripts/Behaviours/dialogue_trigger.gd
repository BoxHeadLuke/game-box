class_name DialogueTrigger
extends Trigger

@export var Dialogue_File : DialogueResource
@export var Start_Flag : String

func start():
	if Globals.in_dialogue:
		return
	var d = Globals.gb_dialogue_balloon.instantiate()
	Globals.gb_root.add_balloon(d)
	d.start(Dialogue_File , Start_Flag)
