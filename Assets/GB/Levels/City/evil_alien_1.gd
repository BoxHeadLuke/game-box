extends Node2D

@export var Trigger_Zone : CollisionShape2D
@export var Animator : AnimationPlayer
@export var Alien : AnimatedSprite2D

func _ready() -> void:
	if Globals.progress_trackers["alien_spotted"]:
		Trigger_Zone.set_deferred("disabled", true)
		Alien.visible = false


func _on_trigger_zone_entered() -> void:
	Globals.progress_trackers["alien_spotted"] = true
	Trigger_Zone.set_deferred("disabled", true)
	Globals.in_dialogue = true
	Animator.play("Fly Away")
	
