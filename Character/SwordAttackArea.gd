extends Area2D

@export var damage: int = 5
@export var actor: Player

@onready var sword_collision_shape: FacingCollisionShape2D = $CollisionShape2D


func _ready() -> void:
	monitoring = false
	actor.facing_direction_changed.connect(on_player_facing_direction_changed)


func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is Damageable:
			# Get direction from sword to body
			var direction_to_damageable = body.global_position - actor.global_position
			var direction_sign = sign(direction_to_damageable.x)
			
			child.hit(damage, direction_sign)


func on_player_facing_direction_changed(facing_right: bool):
	if facing_right:
		sword_collision_shape.position = sword_collision_shape.facing_right_position
	else:
		sword_collision_shape.position = sword_collision_shape.facing_left_position
