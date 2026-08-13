extends Node2D

enum GamePhase {
	KEY,
	RETURN,
	FINAL
}

@export var first_phase_time: float = 60.0
@export var return_phase_time: float = 30.0

var current_phase: GamePhase = GamePhase.KEY
var has_key: bool = false
var has_sword: bool = false
var gold: int = 0

@onready var game_timer: Timer = $GameTimer
@onready var hud = $HUD


func _ready() -> void:
	game_timer.wait_time = first_phase_time
	game_timer.start()

	update_hud()


func _process(_delta: float) -> void:
	hud.set_time(game_timer.time_left)


func collect_key() -> void:
	if has_key:
		return

	has_key = true
	update_hud()


func open_chester() -> void:
	if current_phase != GamePhase.KEY:
		return

	if not has_key:
		hud.set_objective("Necesitas encontrar la llave.")
		return

	has_key = false
	has_sword = true
	gold += 100
	current_phase = GamePhase.RETURN

	game_timer.stop()
	game_timer.wait_time = return_phase_time
	game_timer.start()

	update_hud()

func reach_start() -> void:
	if current_phase != GamePhase.RETURN:
		return

	win_game()


func player_died() -> void:
	get_tree().reload_current_scene()


func win_game() -> void:
	current_phase = GamePhase.FINAL
	game_timer.stop()

	hud.show_victory(gold)

	$Player.set_physics_process(false)


func _on_game_timer_timeout() -> void:
	player_died()


func update_hud() -> void:
	if current_phase == GamePhase.KEY:
		if has_key:
			hud.set_objective("Objetivo: llegar al cofre.")
		else:
			hud.set_objective("Objetivo: encontrar la llave.")

	elif current_phase == GamePhase.RETURN:
		hud.set_objective("¡Volvé al inicio con la espada!")

	hud.set_key(has_key)


func _on_key_collected() -> void:
	collect_key()


func _on_chester_interacted() -> void:
	open_chester()
