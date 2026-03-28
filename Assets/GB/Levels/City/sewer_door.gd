extends Sprite2D

@export var collider : CollisionShape2D
@export var sprite : Sprite2D

var sewer_opened : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not sewer_opened:
		if Globals.progress_trackers["sewer_open"]:
			sewer_opened = true
			collider.set_deferred("disabled", false)
			sprite.frame = 0
