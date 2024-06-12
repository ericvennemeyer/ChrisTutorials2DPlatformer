extends CharacterBody2D


@export var speed: float = 200.0
@export var jump_velocity: float = -150.0
@export var double_jump_velocity: float = -100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped: bool = false
var animation_locked: bool = false
var direction: Vector2 = Vector2.ZERO
var was_in_air: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree


func _ready() -> void:
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false
		if was_in_air:
			land()

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# Normal jump
			jump()
		elif not has_double_jumped:
			# Double jump
			jump_double()

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_facing_direction()


func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)


func update_facing_direction():
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false


func jump():
	velocity.y = jump_velocity
#	animated_sprite_2d.play("jump_start")
	animation_locked = true


func jump_double():
	velocity.y = double_jump_velocity
#	animated_sprite_2d.play("jump_double")
	animation_locked = true
	has_double_jumped = true


func land():
#	animated_sprite_2d.play("jump_end")
	animation_locked = true
	was_in_air = false


#func _on_animated_sprite_2d_animation_finished() -> void:
#	if ["jump_end", "jump_start", "jump_double()"].has(animated_sprite_2d.animation):
#		animation_locked = false
