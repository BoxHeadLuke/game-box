extends Node2D

@export_group("External References")
@export var Player : Node2D
@export_group("Internal References")
@export var Body_Sprite : AnimatedSprite2D
@export var Squash : SquashAndStretch
@export var PortalSquash : SquashAndStretch
@export var Flip : Node2D
@export var Summon_Pos : Node2D

const Speed : float = 4.0

var prev_pos : Vector2
var recent_summons : Array[Node]


func _process(delta: float) -> void:
	
	# Movement
	var target_position : Vector2 = global_position
	if Globals.in_game:
		target_position = Player.sidekick_pos
	else:
		target_position = Player.sidekick_summon_pos
	
	global_position = lerp(global_position , target_position , Speed*delta)
	
	if Player.Visual_Flip.scale.x > 0:
		
		
		if Globals.in_game:
			Body_Sprite.play("right idle")
			Flip.scale.x = -1
		else:
			
			if Player.sidekick_summon_left:
				Body_Sprite.play("right summon")
				Flip.scale.x = 1
			else:
				Body_Sprite.play("left summon")
				Flip.scale.x = -1
			
	elif Player.Visual_Flip.scale.x < 0:
		
		if Globals.in_game:
			Flip.scale.x = 1
			Body_Sprite.play("left idle")
			
		else:
			
			if Player.sidekick_summon_left:
				Body_Sprite.play("right summon")
				Flip.scale.x = 1
			else:
				Body_Sprite.play("left summon")
				Flip.scale.x = -1
	
	if global_position > target_position:
		Body_Sprite.rotation_degrees = -global_position.distance_to(target_position) * 0.4
	else:
		Body_Sprite.rotation_degrees = global_position.distance_to(target_position) * 0.4
	Squash._turn_stretch(Flip.scale.x)
	prev_pos = global_position
	
	
	Flip.visible = not Globals.in_game
	
	
	if not Globals.in_game:
		if Globals.summon_objects.size() > 0:
			var obj = load(Globals.summon_objects[0]).instantiate()
			Globals.summon_objects.remove_at(0)
			Globals.gb_objects.add_child(obj)
			obj.global_position = Summon_Pos.global_position
			obj.process_mode = Node.PROCESS_MODE_PAUSABLE
			recent_summons.append(obj)
			
			PortalSquash._force_stretch(0.5)
			
	else:
		var removed_summons : bool = false
		for obj in recent_summons:
			if obj != null:
				obj.process_mode = Node.PROCESS_MODE_INHERIT
				removed_summons = true
		
		if removed_summons:
			$DialogueTrigger.start()
		recent_summons.clear()
		
	
