class_name TriggerZone
extends Area2D
signal entered

@export var Activate_Trigger : Trigger
@export var keep_layers : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	connect("body_entered", body_entered)
	
	if not keep_layers:
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		set_collision_mask_value(3, true)
	

func body_entered(body):
	if Activate_Trigger:
		Activate_Trigger.start()
	entered.emit()



	
