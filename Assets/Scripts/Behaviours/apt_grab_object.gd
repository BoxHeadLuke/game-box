class_name APTGrabObject
extends RigidBody3D

@export var Use_Default_Material : bool = true
@export var Size : float
@export var Centre : Node3D
@export var GB_Version : String

const default_mass = 0.1
const default_physics_material = "uid://cdjcu8pulisjp"

var prev_velocity : Vector3

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
	
	connect("body_entered", collision)

func _physics_process(delta: float) -> void:
	prev_velocity = linear_velocity

func collision(body):
	pass
	#$AudioStreamPlayer3D.play()
