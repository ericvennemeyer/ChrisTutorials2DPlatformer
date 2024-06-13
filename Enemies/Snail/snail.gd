extends CharacterBody2D

@export var starting_move_direction: Vector2 = Vector2.LEFT
@export var move_speed: float = 30.0

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var character_state_machine: CharacterStateMachine = $CharacterStateMachine


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: Vector2 = starting_move_direction
	if direction and character_state_machine.check_if_can_move():
		velocity.x = direction.x * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()
