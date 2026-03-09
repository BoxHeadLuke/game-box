extends Trigger

@export var grab_object : GBGrabObject
@export var sprite : Sprite2D
@export var float_speed : float
@export var open_collision : CollisionShape2D
@export var closed_collision : CollisionShape2D
var open : bool = true

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func start():
	open = not open
	
	if open:
		sprite.frame = 0
		closed_collision.set_deferred("disabled" , true)
		open_collision.set_deferred("disabled" , false)
		grab_object.gravity_scale = 0.5
	else:
		sprite.frame = 1
		closed_collision.set_deferred("disabled" , false)
		open_collision.set_deferred("disabled" , true)
		grab_object.gravity_scale = 1

func _physics_process(delta: float) -> void:
	if open and Globals.gb_player.grab_object == grab_object:
		Globals.gb_player.velocity.y = min(Globals.gb_player.velocity.y , float_speed)
	
