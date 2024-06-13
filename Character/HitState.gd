class_name HitState
extends State

@export var damageable: Damageable
@export var dead_state: State
@export var dead_animation: String = "dead"


func _ready() -> void:
	damageable.on_hit.connect(on_damageable_hit)


func on_damageable_hit(node: Node, damage_amount: int):
	if damageable.health > 0:
		interrupt_state.emit(self)
	else:
		interrupt_state.emit(dead_state)
		playback.travel(dead_animation)
