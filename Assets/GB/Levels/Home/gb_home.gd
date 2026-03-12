extends GBLevel

@export var Jacko_Dialogue : DialogueResource

var fake_jumps : int = 1
var original_object_count

func _ready() -> void:
	
	
	Globals.gb_objects = Object_Parent
	
	original_object_count = Object_Parent.get_child_count()
	
	if Globals.progress_trackers["home"] <= 0:
		await get_tree().process_frame
	
		Globals.in_game = true
	
		start_dialogue(Jacko_Dialogue, "begin_home")
		Globals.progress_trackers["home"] = 1

func _process(delta: float) -> void:
	if Globals.progress_trackers["home"] <= 2 and Object_Parent.get_child_count() > original_object_count:
		Globals.progress_trackers["home"] = 3
		start_dialogue(Jacko_Dialogue, "first_summon")



func start_dialogue(file, flag):
	if Globals.in_dialogue:
		return
	var d = Globals.gb_dialogue_balloon.instantiate()
	Globals.gb_root.add_child(d)
	d.start(file , flag)
	


func _on_fake_jump_entered(body: Node2D) -> void:
	if Globals.progress_trackers["home"] <= 1:
		if fake_jumps < 1:
			fake_jumps += 1
			
		else:
			
			Globals.progress_trackers["home"] = 2
			await get_tree().create_timer(2.5).timeout
			start_dialogue(Jacko_Dialogue, "fake_jump")
