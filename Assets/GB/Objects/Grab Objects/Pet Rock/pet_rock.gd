extends Trigger

@export var sprite : Sprite2D

func start():
	
	var frame = sprite.frame
	if frame == sprite.hframes-1:
		sprite.frame = 0
		return
	sprite.frame += 1
	
		
	
