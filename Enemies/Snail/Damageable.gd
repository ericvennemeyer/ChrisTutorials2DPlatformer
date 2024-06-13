class_name Damageable
extends Node

signal on_hit(node: Node, damage_taken: int)

@export var actor: CharacterBody2D
@export var health: int = 20:
	get:
		return health
	set(value):
		SignalBus.on_health_changed.emit(actor, value - health)
		health = value
@export var death_animation: String = "dead"

func hit(damage: int):
	health -= damage
	on_hit.emit(actor, damage)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == death_animation:
		# Character is finished dying (death animation complete), remove from game
		actor.queue_free()
