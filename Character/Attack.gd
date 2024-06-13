class_name AttackState
extends State

@export var return_state: State
@export var move_animation: String = "move"
@export var attack1_animation: String = "attack1"
@export var attack2_animation: String = "attack2"

@onready var attack_timer: Timer = $AttackTimer


func state_input(event: InputEvent):
	if event.is_action_pressed("attack"):
		attack_timer.start()


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == attack1_animation:
		if attack_timer.is_stopped():
			next_state = return_state
			playback.travel(move_animation)
		else:
			playback.travel(attack2_animation)
		
	if anim_name == attack2_animation:
		next_state = return_state
		playback.travel(move_animation)
