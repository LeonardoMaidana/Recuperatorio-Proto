extends Area2D

signal player_die


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	player_die.emit()
