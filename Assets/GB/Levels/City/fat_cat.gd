extends Node2D

@export var FC_Sprite : AnimatedSprite2D
@export var Bounce_Zone : BounceZone
@export var Bounce_Dialogue : DialogueTrigger
@export var Bounce_Collision : CollisionShape2D
@export var Pass_Dialogue : DialogueTrigger
@export var Squash : SquashAndStretch


var play_bounced_dialogue : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	if Globals.progress_trackers["fat_cat_passed"]:
		Bounce_Collision.set_deferred("disabled", true)
	
	
	Bounce_Zone.connect("body_entered", bounced)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.gb_player.is_on_floor(): 
		if Globals.gb_player.global_position.x > global_position.x:
			if not Globals.progress_trackers["fat_cat_passed"]:
				Globals.progress_trackers["fat_cat_passed"] = true
				Pass_Dialogue.start()
				
			
		
		elif play_bounced_dialogue:
			play_bounced_dialogue = false
			Bounce_Dialogue.start()
		
	
	if Globals.progress_trackers["fat_cat_passed"]:
		Bounce_Collision.set_deferred("disabled", true)


func bounced(body):
	if body == Globals.gb_player:
		play_bounced_dialogue = true
		Globals.gb_audio.play("Meow")
		Squash._force_stretch(0.7)
		FC_Sprite.play("shock")
		await get_tree().create_timer(0.4).timeout
		FC_Sprite.play("idle")
