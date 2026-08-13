extends Control

@onready var play_button: Button = $MenuCC/MenuVBoxC/PlayButton


func _ready() -> void:
	play_button.grab_focus()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_01.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
