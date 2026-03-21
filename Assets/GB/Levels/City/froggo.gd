extends Node2D

@export var meet_collision : CollisionShape2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not meet_collision.disabled:
		if Globals.progress_trackers["froggo_met"]:
			meet_collision.set_deferred("disabled", true)
