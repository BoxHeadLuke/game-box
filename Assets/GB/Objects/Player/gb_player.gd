extends CharacterBody2D

@export_group("External References")
@export var Sidekick : Node2D

@export_group("Internal References")
@export var Visuals : Node2D
@export var Animator : AnimationPlayer
@export var Squash : SquashAndStretch
@export var Flip_Objects : Node2D
@export var Left_Outer_Foot : RayCast2D
@export var Left_Inner_Foot : RayCast2D
@export var Right_Outer_Foot : RayCast2D
@export var Right_Inner_Foot : RayCast2D
@export var Grab_Point : Node2D
@export var Grab_Point_Damper : Node2D
@export var Grab_Zone : Area2D
@export var Sidekick_Position : Node2D

const Acceleration : float = 300.0
const Run_Acceleration : float = 300.0
const Max_Speed : float = 100.0
const Run_Speed : float = 200.0
const Friction : float = 10.0
const Jump_Force : float = 320.0
const Variable_Jump_Multiplier : float = 0.5
const Gravity : float = 1000.0
const Terminal_Velocity : float = 500.0
const Grav_Down_Multiplier : float = 1.5
const Max_Speed_Snap : float = 1.0
const Jump_Queue_Time : float = 0.1
const Coyote_Time : float = 0.1
const Camera_Offset_Multiplier_X : float = 60
const Camera_Offset_Cutoff : float = 2
const Camera_Offset_Max : float = 100
const Camera_Offset_Speed_X : float = 0.5
const Ledge_Correction_Speed : float = 600
const Camera_Y_Speed_Up : float = 2
const Camera_Y_Speed_Down : float = 10
const Push_Force : float = 2
const Grab_Speed : float = 10
const Grab_Rotation_Speed : float = 10

var input : float
var prev_on_ground : bool = true
var jump_queue_time : float = 0.0
var coyote_time : float = 0.0
var camera_y_pos : float = 0.0
var running : bool = false
var jumping : bool = false
var grab_object : RigidBody2D

# State Machine (Kinda)
enum{
	MOVING,
	DEAD,
	FROZEN
}
var state = MOVING


func _physics_process(delta):
	
	if not Globals.in_game:
		return
	
	input = Input.get_action_strength("GB Right") - Input.get_action_strength("GB Left")
	
	match state:
		MOVING:
			# X-Axis movement
			if Input.is_action_pressed("GB Run") and is_on_floor():
				running = true
			elif not Input.is_action_pressed("GB Run"):
				running = false
			
			# oh my goodness
			if input == 0 or (((velocity.x > Max_Speed or velocity.x < -Max_Speed) and not running) or ((velocity.x > Run_Speed or velocity.x < -Run_Speed) and running)):
				velocity.x = lerpf(velocity.x, 0.0 , Friction * delta)
				
				
			else:
				
				if running:
					
					velocity.x += input * Run_Acceleration * delta
					
					if abs(abs(velocity.x) - abs(Run_Speed)) < Max_Speed_Snap:
						
						if velocity.x > 0:
							velocity.x = Run_Speed
						else:
							velocity.x = -Run_Speed
					
				else:
					
					velocity.x += input * Acceleration * delta
					
					if abs(abs(velocity.x) - abs(Max_Speed)) < Max_Speed_Snap:
						
						if velocity.x > 0:
							velocity.x = Max_Speed
						else:
							velocity.x = -Max_Speed
						
					
				if ((velocity.x > 0 and input < 0) or (velocity.x < 0 and input > 0)) and is_on_floor():
					velocity.x = lerpf(velocity.x, 0.0 , Friction * delta)
			
			# Gravity
			if velocity.y < Terminal_Velocity:
				if velocity.y > 0:
					velocity.y += Gravity * delta * Grav_Down_Multiplier
				else:
					velocity.y += Gravity * delta
			else:
				velocity.y = Terminal_Velocity
			
			# Jump queue and coyote time
			if is_on_floor():
				coyote_time = Coyote_Time
			elif Input.is_action_just_pressed("GB Jump"):
				jump_queue_time = Jump_Queue_Time
			
			# Remove jumping state (for variable jump height triggers)
			if is_on_floor() or velocity.y > 0:
				jumping = false
			
			# Variable jump height
			if jumping and not Input.is_action_pressed("GB Jump"):
				jumping = false
				velocity.y *= Variable_Jump_Multiplier
			
			
			# Jumping
			if (is_on_floor() or coyote_time > 0) and (Input.is_action_just_pressed("GB Jump") or jump_queue_time > 0):
				velocity.y = -Jump_Force
				Squash._force_stretch(1.4)
				jump_queue_time = 0
				coyote_time = 0
				jumping = true
			
			
				
			
			# Legde Correction
			
			
			if is_on_floor() and input == 0 and get_floor_angle() == 0:
				if Left_Outer_Foot.is_colliding() and not Left_Inner_Foot.is_colliding():
					velocity.x -= Ledge_Correction_Speed * delta
				elif Right_Outer_Foot.is_colliding() and not Right_Inner_Foot.is_colliding():
					velocity.x += Ledge_Correction_Speed * delta
			
			move_and_slide()
			
			# Jump timers
			jump_queue_time -= delta
			coyote_time -= delta
			
			# Animations
			
			if input > 0:
				Flip_Objects.scale.x = 1
			elif input < 0:
				Flip_Objects.scale.x = -1
				
			
			Squash._turn_stretch(Flip_Objects.scale.x)
			
			
			if is_on_floor():
				if input == 0:
					Animator.play("Idle")
				else:
					if running:
						Animator.play("Run")
					else:
						Animator.play("Walk")
				if prev_on_ground:
					if jump_queue_time < delta:
						Squash._force_stretch(0.7)
					prev_on_ground = false
			else:
				if velocity.y < 0:
					Animator.play("Jump")
				else:
					Animator.play("Fall")
				prev_on_ground = true
			
			
			# Add to the players velocity on a moving platform, only if they are going in the same direction
			if get_platform_velocity().x != 0:
				if (get_platform_velocity().x > 0 and velocity.x > 0) or (get_platform_velocity().x < 0 and velocity.x < 0):
					platform_on_leave = CharacterBody2D.PLATFORM_ON_LEAVE_ADD_VELOCITY
				else:
					platform_on_leave = CharacterBody2D.PLATFORM_ON_LEAVE_DO_NOTHING
			
			# Push Physics Objects
			for i in get_slide_collision_count():
				var c = get_slide_collision(i)
				if c.get_collider() is RigidBody2D:
					c.get_collider().apply_central_impulse(-c.get_normal() * Push_Force)
			
			if Input.is_action_just_pressed("GB Grab"):
				if grab_object:
					drop()
				else:
					grab()
			
			# Move grab objects
			if grab_object:
				grab_object.position = Grab_Point_Damper.global_position
				grab_object.rotation = Grab_Point_Damper.rotation
				Grab_Point_Damper.position = lerp(Grab_Point_Damper.position, Vector2(0,0) , Grab_Speed*delta)
				Grab_Point_Damper.rotation = lerp_angle(Grab_Point_Damper.rotation , 0.0 , Grab_Rotation_Speed*delta)
		

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
		
		Grab_Point_Damper.global_position = grab_object.global_position
		Grab_Point_Damper.global_rotation = grab_object.global_rotation


func drop():
	grab_object.process_mode = grab_object.PROCESS_MODE_INHERIT
	var temp_grab_object = grab_object
	grab_object = null
	#await get_tree().create_timer(0.1).timeout
	temp_grab_object.apply_central_force(Vector2(Flip_Objects.scale.x * 500, -500) + (velocity*5))
