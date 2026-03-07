class_name PlayerAttackTrigger
extends Trigger

@export var Attack_Anim : String
@export var Attack_Sprite : Texture
@export var Make_Invisible : Node
@export var Fade : bool = true
@export var Fade_Speed = 100
func _ready() -> void: if Make_Invisible: process_mode = Node.PROCESS_MODE_ALWAYS

func start():
	Globals.gb_player.attack(Attack_Anim, Attack_Sprite)

func _process(delta: float) -> void:
	if Make_Invisible:
		if  Fade:
			if ((Make_Invisible == Globals.gb_player.grab_object) and Globals.gb_player.attacking):
				Make_Invisible.modulate.a = lerp(Make_Invisible.modulate.a , 0.0 , Fade_Speed * delta)
			else:
				Make_Invisible.modulate.a = lerp(Make_Invisible.modulate.a , 255.0 , Fade_Speed * delta)
		else:
			Make_Invisible.visible = not ((Make_Invisible == Globals.gb_player.grab_object) and Globals.gb_player.attacking)
			
