extends GBLevel

var ready_to_start = false

func _init() -> void:
	Globals.in_game = true
	Globals.progress_trackers["switch_enabled"] = false
	Globals.progress_trackers["summon_enabled"] = false
	


func _process(delta: float) -> void:
	
	if not ready_to_start:
		ready_to_start = true
	
		$AnimationPlayer.play("start")
		await $AnimationPlayer.animation_finished
		$DialogueTrigger.start()
		await DialogueManager.dialogue_ended
		$AnimationPlayer.play("slideshow")
		
		await $AnimationPlayer.animation_finished
		
		
		
