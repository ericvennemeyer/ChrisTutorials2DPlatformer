extends Area2D

@export var damage: int = 5
@export var actor: CharacterBody2D


func _ready() -> void:
	monitoring = false


func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is Damageable:
			# Get direction from sword to body
			var direction_to_damageable = body.global_position - actor.global_position
			var direction_sign = sign(direction_to_damageable.x)
			
			child.hit(damage, direction_sign)
			
