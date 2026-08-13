extends CharacterBody2D

@export var speed: int = 130
@export var jump_force: int = -280
@export var gravity: int = 600
var last_h_direction = 1
func _physics_process(delta: float) -> void:
	_gravity(delta)
	_movement()
	_jump()
	move_and_slide()


func _gravity(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta


func _movement() -> void:
	var direction: float = Input.get_axis("move_left","move_right")
	
	if direction:
		velocity.x = direction * speed
		last_h_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func _jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
