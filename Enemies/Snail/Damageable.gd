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


func hit(damage: int):
	health -= damage
	on_hit.emit(actor, damage)
	
