class_name AirState
extends State

@export var double_jump_velocity: float = -100.0
@export var landing_state: LandingState
@export var double_jump_animation: String = "double_jump"
@export var landing_animation: String = "jump_end"

var has_double_jumped: bool = false

func state_process(delta):
	if character.is_on_floor():
		next_state = landing_state


func state_input(event):
	if Input.is_action_just_pressed("jump") and not has_double_jumped:
		jump_double()


func jump_double():
	character.velocity.y = double_jump_velocity
	playback.travel(double_jump_animation)
	has_double_jumped = true


func on_exit():
	if next_state == landing_state:
		playback.travel(landing_animation)
		has_double_jumped = false
