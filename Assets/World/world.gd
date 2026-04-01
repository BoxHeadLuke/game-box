extends Node3D

@export var Appartment : Node3D
@export var GameBox : Node2D

@export var Screen_Cam : PhantomCamera3D
@export var TV_Particles : Node3D

func _ready() -> void:
	Globals.apt_root = $Appartment
	Globals.gb_root = $"Game Box/GameBox"
	
	await get_tree().create_timer(3).timeout
	var ss = $"Game Box".get_texture().get_image()
	
	ss.save_png("res://screenshot.png")


func _process(delta: float) -> void:
	
	
	if Globals.in_game:
		Screen_Cam.priority = 2
		Appartment.process_mode = Node.PROCESS_MODE_DISABLED
		GameBox.process_mode = Node.PROCESS_MODE_ALWAYS
	else:
		Screen_Cam.priority = 0
		GameBox.process_mode = Node.PROCESS_MODE_DISABLED
		Appartment.process_mode = Node.PROCESS_MODE_ALWAYS


func _on_screen_zone_body_entered(body: Node3D) -> void:
	if body.is_in_group("grab_object"):
		#TV_Particles.global_position = body.Centre.global_position
		
		for particles in TV_Particles.get_children():
			particles.global_position = body.Centre.global_position
			
			particles.set_deferred("emission_sphere_radius" , body.Size)
			
			particles.set_deferred("emitting" , true)
			particles.visible = false
		
		await get_tree().process_frame
		for particles in TV_Particles.get_children():
			particles.visible = true
		
		Globals.summon_objects.append(body.GB_Version)
		Globals.spawner_list.append(body.spawner)
		body.queue_free()
