class_name Damageable
extends Node

@export var actor: CharacterBody2D
@export var health: int = 20:
	get:
		return health
	set(value):
		SignalBus.on_health_changed.emit(actor, value - health)
		health = value


func hit(damage: int):
	health -= damage
	print("Snail took " + str(damage) + " damage")
	
	if health <= 0:
		actor.queue_free()
