extends CanvasLayer

signal round_finished()

@onready var round_counter_label: NinePatchRect = %RoundCounterLabel

func set_round_count(rounds: int) -> void:
	round_counter_label.set_round_count(rounds)

func _on_finish_round_button_pressed() -> void:
	emit_signal("round_finished")
