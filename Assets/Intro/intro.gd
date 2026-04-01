extends Node2D

var main_game = preload("uid://c0obricqshh07")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Control/Label2/AnimationPlayer.play("pulse")
	$CanvasLayer/Control/AnimationPlayer.play("slideshow")
	await $CanvasLayer/Control/AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(main_game)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Jump"):
		get_tree().change_scene_to_packed(main_game)
		
		
		
		
		
		
