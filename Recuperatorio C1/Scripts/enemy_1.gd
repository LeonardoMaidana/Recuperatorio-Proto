extends CharacterBody2D

signal player_contact(enemy, player)

@export var speed: float = 50.0
@export var patrol_distance: float = 100.0

var direction: float = 1.0
var start_x: float
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_defeated: bool = false

@onready var sprite: AnimatedSprite2D = $Enemy1Animation


func _ready() -> void:
	start_x = global_position.x


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = speed * direction

	if global_position.x >= start_x + patrol_distance:
		direction = -1.0
		flip_sprite()

	elif global_position.x <= start_x - patrol_distance:
		direction = 1.0
		flip_sprite()

	move_and_slide()


func flip_sprite() -> void:
	sprite.flip_h = direction < 0


func _on_enemy_1_area_hitbox_body_entered(body: Node2D) -> void:
	pass

	if not body.is_in_group("player"):
		return

	player_contact.emit(self, body)


func defeat() -> void:
	if is_defeated:
		return

	is_defeated = true
	set_physics_process(false)
	$Enemy1AreaHitbox.set_deferred("monitoring", false)

	call_deferred("queue_free")
