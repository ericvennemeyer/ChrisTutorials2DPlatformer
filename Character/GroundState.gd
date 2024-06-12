class_name GroundState
extends State

@export var jump_velocity: float = -150.0
@export var air_state: AirState
@export var jump_animation: String = "jump"


func state_process(delta):
	if not character.is_on_floor():
		next_state = air_state


func state_input(event: InputEvent):
	if Input.is_action_just_pressed("jump"):
		jump()


func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
