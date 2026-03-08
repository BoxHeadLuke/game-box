class_name DialogueZone
extends Area2D

@export var Speech_Bubble : Node
@export var Dialogue_Trigger : DialogueTrigger

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(3, true)
	
	connect("body_entered" , body_entered)
	connect("body_exited" , body_exited)

func body_entered(body):
	if not Speech_Bubble:
		return
	if body == Globals.gb_player:
		Speech_Bubble.appear()
		

func body_exited(body):
	if not Speech_Bubble:
		return
	if body == Globals.gb_player:
		Speech_Bubble.disappear()
		


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Up"):
		if Globals.gb_player in get_overlapping_bodies():
			Dialogue_Trigger.start()
	
