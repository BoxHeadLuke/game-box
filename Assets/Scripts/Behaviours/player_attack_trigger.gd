class_name PlayerAttackTrigger
extends Trigger

@export var Attack_Anim : String
@export var Attack_Sprite : Texture
@export var Weapon : Node
@export var Make_Invisible : Node
@export var Fade : bool = true
@export var Fade_Speed : float = 30

var colour : float = 255

func _ready() -> void: if Make_Invisible: process_mode = Node.PROCESS_MODE_ALWAYS

func start():
	Globals.gb_player.attack(Attack_Anim, Attack_Sprite)

func _process(delta: float) -> void:
	if Make_Invisible:
		#print(((Weapon == Globals.gb_player.grab_object) and Globals.gb_player.attacking))
		
		
		
		if  Fade:
			if ((Weapon == Globals.gb_player.grab_object) and Globals.gb_player.attacking):
				colour = lerp(colour , 0.0 , Fade_Speed * delta)
				
				
			else:
				colour = lerp(colour , 1.0 , Fade_Speed * delta)
			
			colour = clamp(colour , 0, 1.0)
				
			Make_Invisible.modulate.a = colour
			
			print(colour)
			
		else:
			Make_Invisible.visible = not ((Weapon == Globals.gb_player.grab_object) and Globals.gb_player.attacking)
			
