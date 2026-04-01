extends CharacterBody2D

@export var Flip : Node2D
@export var Animator : AnimationPlayer
@export var Squash : SquashAndStretch


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
const Push_Force : float = 2


var input : float
var prev_on_ground : bool = true
var jump_queue_time : float = 0.0
var coyote_time : float = 0.0
var camera_y_pos : float = 0.0
var running : bool = false
var jumping : bool = false
var is_flipped : bool
var prev_velocity : Vector2

func _physics_process(delta: float) -> void:
	
			input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	
			# X-Axis movement
			if Input.is_action_pressed("Run") and is_on_floor():
				running = true
			elif not Input.is_action_pressed("Run"):
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
			elif Input.is_action_just_pressed("Jump"):
				jump_queue_time = Jump_Queue_Time
			
			# Remove jumping state (for variable jump height triggers)
			if is_on_floor() or velocity.y > 0:
				jumping = false
			
			# Variable jump height
			if jumping and not Input.is_action_pressed("Jump"):
				jumping = false
				velocity.y *= Variable_Jump_Multiplier
			
			
			# Jumping
			if (is_on_floor() or coyote_time > 0) and (Input.is_action_just_pressed("Jump") or jump_queue_time > 0) :
				velocity.y = -Jump_Force
				Squash._force_stretch(1.4)
				jump_queue_time = 0
				coyote_time = 0
				jumping = true
				
			
				
			
			# Legde Correction
			
			
			
			move_and_slide()
			
			# Jump timers
			jump_queue_time -= delta
			coyote_time -= delta
			
			# Animations
			
			# Flip both the visual and functional things that need to be flipped
			# Depends on input direction
			# Visual flip objects are also squash and stretced B)
			if input > 0:
				
				Flip.scale.x = 1
				is_flipped = false
			elif input < 0:
				
				Flip.scale.x = -1
				is_flipped = true
				
			Squash._turn_stretch(Flip.scale.x)
			
			
			
			# Play animations and squash&stretch on landing
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
					
					if prev_velocity.y > 10:
						#Globals.gb_audio.play("Player Land")
						pass
			else:
				if velocity.y < 0:
					Animator.play("Jump")
				else:
					Animator.play("Fall")
				prev_on_ground = true
			
			# Push Physics Objects
			for i in get_slide_collision_count():
				var c = get_slide_collision(i)
				if c.get_collider() is RigidBody2D:
					c.get_collider().apply_central_impulse(-c.get_normal() * Push_Force)
			
			prev_velocity = velocity
