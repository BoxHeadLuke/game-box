class_name SecretArea
extends Area2D


const fade_speed = 20

func _ready() -> void:
	visible = true
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(3, true)
	


func _process(delta: float) -> void:
	if get_overlapping_bodies().size() > 0:
		modulate.a = lerp(modulate.a, 0.0, fade_speed*delta)
	else:
		modulate.a = lerp(modulate.a, 1.0, fade_speed*delta)
