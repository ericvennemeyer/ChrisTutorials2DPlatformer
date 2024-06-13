class_name HitState
extends State

@export var damageable: Damageable
@export var dead_state: State
@export var dead_animation: String = "dead"
@export var knockback_speed: float = 100.0
@export var return_state: State

@onready var timer: Timer = $Timer


func _ready() -> void:
	damageable.on_hit.connect(on_damageable_hit)


func on_enter():
	timer.start()


func on_damageable_hit(node: Node, damage_amount: int, direction: int):
	if damageable.health > 0:
		character.velocity = knockback_speed * Vector2(direction, 0)
		interrupt_state.emit(self)
	else:
		interrupt_state.emit(dead_state)
		playback.travel(dead_animation)


func on_exit():
	character.velocity = Vector2.ZERO


func _on_timer_timeout() -> void:
	next_state = return_state
