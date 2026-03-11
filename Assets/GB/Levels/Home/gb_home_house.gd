extends StaticBody2D

@export var House_Area : Area2D
@export var House_Outside : Sprite2D

var fade_speed : float = 20.0

func _process(delta: float) -> void:
	if House_Area.get_overlapping_bodies().size() >0:
		House_Outside.modulate.a = lerp(House_Outside.modulate.a, 0.0 , fade_speed*delta)
	else:
		House_Outside.modulate.a = lerp(House_Outside.modulate.a, 1.0 , fade_speed*delta)
