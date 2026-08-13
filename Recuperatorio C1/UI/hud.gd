extends CanvasLayer

@onready var time_label: Label = $TimeLabel
@onready var objective_label: Label = $ObjectiveLabel
@onready var key_label: Label = $KeyLabel


func set_time(seconds: float) -> void:
	time_label.text = "Tiempo: %d" % int(ceil(seconds))


func set_objective(text: String) -> void:
	objective_label.text = text


func set_key(has_key: bool) -> void:
	key_label.text = "Llave: " + ("SI" if has_key else "NO")


func show_victory(gold: int) -> void:
	time_label.text = ""
	objective_label.text = "¡VICTORIA!"
	key_label.text = "Oro: %d" % gold
