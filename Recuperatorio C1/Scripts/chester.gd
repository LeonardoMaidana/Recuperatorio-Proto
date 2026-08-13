extends Area2D

signal interacted


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	interacted.emit()
