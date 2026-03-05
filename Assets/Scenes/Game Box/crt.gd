extends CanvasLayer

@export var CRT_Effect : ColorRect
@export var Animator : AnimationPlayer

var prev_in_game : bool = true

func _ready() -> void:
	visible = true

func _process(delta: float) -> void:
	
	if Globals.in_game and not prev_in_game:
		Animator.play_backwards("Fade CRT")
	if not Globals.in_game and prev_in_game:
		Animator.play_backwards("Fade CRT")
		Animator.play("Fade CRT")
	
	prev_in_game = Globals.in_game
