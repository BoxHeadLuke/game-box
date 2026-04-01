extends Node2D
var alien_girl_joined : bool = false
var cowboy_joe_joined : bool = false
var fat_cat_joined : bool = false
var ricky_rats_joined : bool = false
var dancing = false


func _process(delta: float) -> void:
	
	if Globals.progress_trackers["concert_active"]:
		$"../Froggo/AnimatedSprite2D".play("sing")
		print(true)
		$PhantomCamera2D.priority = 1000
		if not dancing:
			$AnimationPlayer.play("Dance")
			dancing = true
			
	else:
		$"../Froggo/AnimatedSprite2D".play("default")
		$PhantomCamera2D.priority = 0
		$AnimationPlayer.stop()
		
	
	
	if Globals.in_dialogue:
		return
	
	if not alien_girl_joined:
		if Globals.progress_trackers["alien_girl_instrument"] != "None":
			alien_girl_joined = true
			$"../Totally Human Girl".queue_free()
			$"Alien Girl/DialogueZone3/CollisionShape2D".set_deferred("disabled", false)
			$"Alien Girl".visible = true
			
			for ins in $"Alien Girl/Instrument".get_children():
				ins.visible = Globals.progress_trackers["alien_girl_instrument"] == ins.name
	
	if not cowboy_joe_joined:
		if Globals.progress_trackers["cowboy_joe_instrument"] != "None":
			cowboy_joe_joined = true
			$"../Cowboy Joe".queue_free()
			$"Cowboy Joe/DialogueZone4/CollisionShape2D".set_deferred("disabled", false)
			$"Cowboy Joe".visible = true
			
			for ins in $"Cowboy Joe/Instrument".get_children():
				ins.visible = Globals.progress_trackers["cowboy_joe_instrument"] == ins.name
			
	
	if not fat_cat_joined:
		if Globals.progress_trackers["fat_cat_instrument"] != "None":
			fat_cat_joined = true
			$"../Fat Cat".queue_free()
			$FatCat/DialogueZone/CollisionShape2D.set_deferred("disabled", false)
			$FatCat.visible = true
			
			
	
	if not ricky_rats_joined:
		if Globals.progress_trackers["ricky_rats_instrument"] != "None":
			ricky_rats_joined = true
			$"../Ricky Rats".queue_free()
			$"Ricky Rats/DialogueZone2/CollisionShape2D".set_deferred("disabled", false)
			$"Ricky Rats".visible = true
			
			for ins in $"Ricky Rats/Instrument".get_children():
				ins.visible = Globals.progress_trackers["ricky_rats_instrument"] == ins.name
		
		
	
		
