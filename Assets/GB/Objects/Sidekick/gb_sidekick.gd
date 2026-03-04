extends Node2D

@export var Player : Node2D
@onready var Squash = $SquashAndStretch
@onready var Flip = $Flip
@onready var Body_Sprite = $Flip/AnimatedSprite2D

const Speed : float = 4.0

var prev_pos : Vector2
var direction : float = 1

func _process(delta: float) -> void:
	global_position = lerp(global_position , Player.Sidekick_Position.global_position , Speed*delta)
	
	if Player.Flip_Objects.scale.x > 0:
		direction = 1
		Body_Sprite.play("left")
	elif Player.Flip_Objects.scale.x < 0:
		direction = -1
		Body_Sprite.play("right")
	
	
	
	if global_position > Player.Sidekick_Position.global_position:
		Flip.rotation_degrees = -global_position.distance_to(Player.Sidekick_Position.global_position) * 0.4
	else:
		Flip.rotation_degrees = global_position.distance_to(Player.Sidekick_Position.global_position) * 0.4
	Squash._turn_stretch(Flip.scale.x)
	prev_pos = global_position
	
