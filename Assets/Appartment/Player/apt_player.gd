extends CharacterBody3D

@export var Head : Node3D
@export var Grab_Zone : Area3D
@export var Grab_Point : Node3D
@export var Mouse_Sensitivity : float = 0.07

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

const GRAB_SPEED : float = 10
const GRAB_ROT_SPEED : float = 10

var grab_object : Node3D


func _physics_process(delta: float) -> void:
	
	if Globals.in_game:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("APT Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("APT Left", "APT Right", "APT Forward", "APT Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("APT Grab"):
		if grab_object:
			drop()
		else:
			grab()
	
	
	if grab_object:
		#grab_object.global_position = lerp(grab_object.global_position , Grab_Point.global_position , GRAB_SPEED * delta)
		#grab_object.global_rotation = lerp(grab_object.global_rotation , Grab_Point.rotation , GRAB_SPEED * delta)
		grab_object.global_transform = grab_object.global_transform.interpolate_with(Grab_Point.global_transform, GRAB_SPEED * delta)

func _unhandled_input(event: InputEvent) -> void:
	
	if Globals.in_game:
		return
	
	if event is InputEventMouseMotion:
		var relative = event.relative * Mouse_Sensitivity
		rotate_y(-relative.x)
		Head.rotate_x(-relative.y)
		Head.rotation_degrees.x = clamp(Head.rotation_degrees.x , -89 , 89)



func grab():
	var current_grab_object : Node = null
	var current_grab_distance : float = 99999.0
	for obj in Grab_Zone.get_overlapping_bodies():
		if obj.is_in_group("grab_object"):
			if Grab_Point.global_position.distance_to(obj.global_position) < current_grab_distance:
				current_grab_object = obj
				current_grab_distance = Grab_Point.global_position.distance_to(obj.global_position) < current_grab_distance
	
	if current_grab_object:
		grab_object = current_grab_object
		
		
		grab_object.process_mode = grab_object.PROCESS_MODE_DISABLED
		


func drop():
	grab_object.process_mode = grab_object.PROCESS_MODE_INHERIT
	var temp_grab_object = grab_object
	grab_object = null
	#await get_tree().create_timer(0.1).timeout
	temp_grab_object.apply_central_force( (-Head.global_basis.z * 20) + (velocity*5) + (Vector3(0,4,0)))
