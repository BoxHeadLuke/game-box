extends CanvasLayer


@export var Trans_Animator : AnimationPlayer

func trans_out():
	Trans_Animator.play("Trans Out")

func trans_in():
	Trans_Animator.play("Trans In")
