extends Node2D

@export_group("External References")
@export var Player : Node2D
@export_group("Internal References")
@export var Body_Sprite : AnimatedSprite2D
@export var Squash : SquashAndStretch
@export var Flip : Node2D

const Speed : float = 4.0

var prev_pos : Vector2

func _process(delta: float) -> void:
	global_position = lerp(global_position , Player.Sidekick_Position.global_position , Speed*delta)
	
	if Player.Flip_Objects.scale.x > 0:
		Flip.scale.x = -1
		if Globals.in_game:
			Body_Sprite.play("right idle")
		else:
			Body_Sprite.play("left summon")
	elif Player.Flip_Objects.scale.x < 0:
		Flip.scale.x = 1
		if Globals.in_game:
			Body_Sprite.play("left idle")
		else:
			Body_Sprite.play("right summon")
	
	
	
	if global_position > Player.Sidekick_Position.global_position:
		Body_Sprite.rotation_degrees = -global_position.distance_to(Player.Sidekick_Position.global_position) * 0.4
	else:
		Body_Sprite.rotation_degrees = global_position.distance_to(Player.Sidekick_Position.global_position) * 0.4
	Squash._turn_stretch(Flip.scale.x)
	prev_pos = global_position
	
	
	Flip.visible = not Globals.in_game
