class_name BounceZone
extends Area2D

@export var bounce_force : float = 10
@export var direction : Vector2 = Vector2(0,-1)
@export var set_y_vel : bool = true
@export var set_x_vel : bool = false

func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(3, true)
	
	connect("body_entered", body_entered)

func body_entered(body):
	
	if set_x_vel:
		body.velocity.x = bounce_force * direction.x
	else:
		body.velocity.x += bounce_force * direction.x
	
	if set_y_vel:
		body.velocity.y = bounce_force * direction.y
	else:
		body.velocity.y += bounce_force * direction.y
