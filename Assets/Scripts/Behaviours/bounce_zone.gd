class_name BounceZone
extends Area2D

@export var bounce_force : float = 10

func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(3, true)
	
	connect("body_entered", body_entered)

func body_entered(body):
	body.velocity.y = -bounce_force
