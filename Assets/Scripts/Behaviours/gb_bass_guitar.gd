class_name GBGrabObject
extends RigidBody2D

@export var Use_Default_Material : bool = true
@export var Impact_Sound : String = "Wood Impact"
@export var Use_Trigger : Trigger
@export var Squash_And_Stretch : SquashAndStretch

const default_mass = 0.1
const use_stretch = 0.6
const default_physics_material = "uid://bqk7vm4mlq2h5"

var prev_velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, true)
	add_to_group("grab_object")
	
	if Use_Default_Material:
		mass = default_mass
		var phys = load(default_physics_material)
		physics_material_override = phys
	
	disable_mode = CollisionObject2D.DISABLE_MODE_MAKE_STATIC
	contact_monitor = true
	max_contacts_reported = 5
	can_sleep = false
	connect("body_entered", collision)

func _physics_process(delta: float) -> void:
	prev_velocity = linear_velocity
	
	

func collision(body):
	if prev_velocity.length() > 100:
		Globals.gb_audio.play(Impact_Sound)

func use():
	if Use_Trigger:
		Use_Trigger.start()
		if Squash_And_Stretch:
			Squash_And_Stretch._force_stretch(use_stretch)
