extends Control

@onready var round_counter = $RoundCounter

signal finish_round()

func _ready():
	mouse_filter = Control.MouseFilter.MOUSE_FILTER_PASS

func _on_finish_round_pressed() -> void:
	round_counter.increase_round_count()
	emit_signal("finish_round")
