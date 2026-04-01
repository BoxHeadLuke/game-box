class_name ParticleTrigger
extends Trigger

@export var particles : GPUParticles2D
@export var time : float = 1


func start():
	particles.emitting = true
	
	
