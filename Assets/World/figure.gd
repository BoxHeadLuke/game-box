extends Node3D


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if Globals.throw_figure:
		Globals.throw_figure = false
		$"../AnimationPlayer".play("throw figure")
		await $"../AnimationPlayer".animation_finished
		Globals.gb_root.switch_level("uid://3722kpav0b6h")
