extends Node2D

@export var Trigger_Zone : CollisionShape2D
@export var Animator : AnimationPlayer
@export var Dialogue : DialogueTrigger
@export var Alien :AnimatedSprite2D
@export var Portal_Frame : AnimatedSprite2D

func _ready() -> void:
	if Globals.progress_trackers["alien_exited"]:
		Trigger_Zone.set_deferred("disabled", true)
		Alien.visible = false
		
		if not Globals.progress_trackers["doorway_unlocked"]:
			Portal_Frame.visible = false
	


func _on_trigger_zone_entered() -> void:
	Globals.progress_trackers["alien_exited"] = true
	Trigger_Zone.set_deferred("disabled", true)
	Globals.in_dialogue = true
	Animator.play("Fly Away")
	await get_tree().create_timer(0.9).timeout
	Globals.in_dialogue = false
	Dialogue.start()
