extends Node2D

@onready var Sway_Animator = $"Sway Animator"
@onready var Appear_Animator = $"Appear Animator"

func _ready() -> void:
	Sway_Animator.play("Sway")

func appear():
	Appear_Animator.play("Appear")

func disappear():
	Appear_Animator.play_backwards("Appear")
