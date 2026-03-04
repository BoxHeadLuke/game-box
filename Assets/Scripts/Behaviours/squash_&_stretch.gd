class_name SquashAndStretch
extends Node

@export var node : Node2D
@export var speed = 10
@export var turn_amount = 1.3

var prev_value = 1

# Return to normal
func _process(delta):
	
	node.scale.y = lerpf(node.scale.y , 1 , speed * delta)
	node.scale.x = 1/node.scale.y

# Stretch when the character turns around
func _turn_stretch(value):
	if prev_value != value:
		node.scale.y = turn_amount
	
	prev_value = value

# Start a stretch with custom values
func _force_stretch(amount):
	node.scale.y = amount
